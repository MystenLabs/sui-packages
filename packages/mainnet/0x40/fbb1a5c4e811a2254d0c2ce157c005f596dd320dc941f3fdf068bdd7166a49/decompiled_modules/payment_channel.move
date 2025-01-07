module 0x40fbb1a5c4e811a2254d0c2ce157c005f596dd320dc941f3fdf068bdd7166a49::payment_channel {
    struct ChannelRegistry has store, key {
        id: 0x2::object::UID,
        payer_to_channels: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        payee_to_channels: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct Claim has store, key {
        id: 0x2::object::UID,
        channel: 0x2::object::ID,
        title: 0x1::string::String,
        meta_url: 0x1::string::String,
        payee_accept: bool,
        amount: u64,
        created_date: u64,
        status: u64,
    }

    struct Channel has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        payer: address,
        payee: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        created_date: u64,
        end_date: u64,
        claims: 0x2::vec_set::VecSet<0x2::object::ID>,
        status: u64,
    }

    public entry fun accept_claim(arg0: &mut Channel, arg1: &mut Claim, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.claims, 0x2::object::borrow_id<Claim>(arg1)), 5);
        assert!(&v0 == &arg0.payee, 1);
        assert!(arg0.status == 1, 2);
        assert!(arg1.status == 1, 4);
        arg1.payee_accept = true;
        arg1.status = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1.amount, arg2), v0);
    }

    public entry fun close_channel(arg0: &mut Channel, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(&v0 == &arg0.payer || &v0 == &arg0.payee, 3);
        arg0.status = 2;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v1, arg1), arg0.payer);
        };
    }

    public entry fun create_channel(arg0: &mut ChannelRegistry, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Channel{
            id           : 0x2::object::new(arg5),
            title        : 0x1::string::utf8(arg1),
            payer        : v0,
            payee        : arg3,
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            created_date : 0x2::clock::timestamp_ms(arg4),
            end_date     : arg2,
            claims       : 0x2::vec_set::empty<0x2::object::ID>(),
            status       : 1,
        };
        if (!0x2::vec_map::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.payee_to_channels, &arg3)) {
            0x2::vec_map::insert<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.payee_to_channels, arg3, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.payee_to_channels, &arg3), 0x2::object::id<Channel>(&v1));
        if (!0x2::vec_map::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.payer_to_channels, &v0)) {
            0x2::vec_map::insert<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.payer_to_channels, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.payer_to_channels, &v0), 0x2::object::id<Channel>(&v1));
        0x2::transfer::share_object<Channel>(v1);
    }

    public entry fun create_claim(arg0: &mut Channel, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(&v0 == &arg0.payer, 0);
        let v1 = Claim{
            id           : 0x2::object::new(arg5),
            channel      : 0x2::object::id<Channel>(arg0),
            title        : 0x1::string::utf8(arg1),
            meta_url     : 0x1::string::utf8(arg2),
            payee_accept : false,
            amount       : arg3,
            created_date : 0x2::clock::timestamp_ms(arg4),
            status       : 1,
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.claims, 0x2::object::id<Claim>(&v1));
        0x2::transfer::share_object<Claim>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChannelRegistry{
            id                : 0x2::object::new(arg0),
            payer_to_channels : 0x2::vec_map::empty<address, 0x2::vec_set::VecSet<0x2::object::ID>>(),
            payee_to_channels : 0x2::vec_map::empty<address, 0x2::vec_set::VecSet<0x2::object::ID>>(),
        };
        0x2::transfer::share_object<ChannelRegistry>(v0);
    }

    public entry fun reject_claim(arg0: &mut Channel, arg1: &mut Claim, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.claims, 0x2::object::borrow_id<Claim>(arg1)), 5);
        assert!(&v0 == &arg0.payee, 1);
        assert!(arg0.status == 1, 2);
        assert!(arg1.status == 1, 4);
        arg1.payee_accept = false;
        arg1.status = 3;
    }

    public entry fun send_fund(arg0: &mut Channel, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(&v0 == &arg0.payer || &v0 == &arg0.payee, 3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    // decompiled from Move bytecode v6
}

