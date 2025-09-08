module 0xa0da6a77a18c9757674e18156345514c9a78569336352fd906f04e34c8ebffc9::donation_campaign {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    struct Campaign has store, key {
        id: 0x2::object::UID,
        creator: address,
        title: vector<u8>,
        description: vector<u8>,
        goal: u64,
        raised: u64,
        donations: vector<DonationRecord>,
        is_active: bool,
    }

    struct DonationRecord has store {
        donor: address,
        amount: u64,
    }

    struct CampanaCreada has copy, drop {
        campaign_id: 0x2::object::ID,
        creator: address,
        goal: u64,
    }

    struct DonacionRecibida has copy, drop {
        campaign_id: 0x2::object::ID,
        donor: address,
        amount: u64,
    }

    struct FondosRetirados has copy, drop {
        campaign_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    entry fun crear_campana(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            abort 0
        };
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Campaign{
            id          : 0x2::object::new(arg3),
            creator     : v0,
            title       : arg0,
            description : arg1,
            goal        : arg2,
            raised      : 0,
            donations   : 0x1::vector::empty<DonationRecord>(),
            is_active   : true,
        };
        let v2 = CampanaCreada{
            campaign_id : 0x2::object::id<Campaign>(&v1),
            creator     : v0,
            goal        : arg2,
        };
        0x2::event::emit<CampanaCreada>(v2);
        0x2::transfer::public_transfer<Campaign>(v1, v0);
    }

    public fun donar(arg0: &mut Campaign, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!arg0.is_active) {
            abort 1
        };
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        if (v1 == 0) {
            abort 2
        };
        if (arg0.raised + v1 > arg0.goal) {
            abort 3
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.raised = arg0.raised + v1;
        let v2 = DonationRecord{
            donor  : v0,
            amount : v1,
        };
        0x1::vector::push_back<DonationRecord>(&mut arg0.donations, v2);
        let v3 = DonacionRecibida{
            campaign_id : 0x2::object::id<Campaign>(arg0),
            donor       : v0,
            amount      : v1,
        };
        0x2::event::emit<DonacionRecibida>(v3);
        if (arg0.raised == arg0.goal) {
            arg0.is_active = false;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            owner   : v0,
        };
        0x2::transfer::public_transfer<Treasury>(v1, v0);
    }

    public fun obtener_info_campana(arg0: &Campaign) : (address, vector<u8>, u64, u64, bool) {
        (arg0.creator, arg0.title, arg0.goal, arg0.raised, arg0.is_active)
    }

    public fun obtener_monto_donacion(arg0: &Campaign, arg1: address) : u64 {
        let v0 = &arg0.donations;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<DonationRecord>(v0)) {
            let v3 = 0x1::vector::borrow<DonationRecord>(v0, v2);
            if (v3.donor == arg1) {
                v1 = v1 + v3.amount;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun retirar_fondos(arg0: &mut Campaign, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator, 4);
        assert!(arg0.raised > 0, 5);
        let v1 = arg0.raised;
        arg0.raised = 0;
        arg0.is_active = false;
        let v2 = FondosRetirados{
            campaign_id : 0x2::object::id<Campaign>(arg0),
            creator     : v0,
            amount      : v1,
        };
        0x2::event::emit<FondosRetirados>(v2);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v1, arg2)
    }

    public fun retirar_fondos_de_tesoreria(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (v0 != arg0.owner) {
            abort 4
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < arg1) {
            abort 5
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg3), arg2);
        let v1 = FondosRetirados{
            campaign_id : 0x2::object::id<Treasury>(arg0),
            creator     : v0,
            amount      : arg1,
        };
        0x2::event::emit<FondosRetirados>(v1);
    }

    // decompiled from Move bytecode v6
}

