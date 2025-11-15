module 0x1243ce444123578c129d5a52fe02e7abd02f87b1f1dc31c31f8e2a43975569e7::vakinha {
    struct Vakinha has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        goal_amount: u64,
        amount_donated: u64,
        owner: address,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        is_active: bool,
    }

    struct VakinhaCreated has copy, drop {
        vakinha_id: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        owner: address,
        goal_amount: u64,
        amount_donated: u64,
        is_active: bool,
    }

    struct DonationMade has copy, drop {
        vakinha_id: address,
        donor: address,
        amount: u64,
        total_donated: u64,
    }

    struct WithdrawMade has copy, drop {
        vakinha_id: address,
        owner: address,
        amount: u64,
    }

    public fun create_vakinha(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Vakinha{
            id             : 0x2::object::new(arg4),
            name           : arg0,
            description    : arg2,
            image_url      : arg1,
            goal_amount    : arg3,
            amount_donated : 0,
            owner          : v0,
            balance        : 0x2::coin::zero<0x2::sui::SUI>(arg4),
            is_active      : true,
        };
        let v2 = VakinhaCreated{
            vakinha_id     : 0x2::object::uid_to_address(&v1.id),
            name           : v1.name,
            description    : v1.description,
            image_url      : v1.image_url,
            owner          : v0,
            goal_amount    : arg3,
            amount_donated : 0,
            is_active      : true,
        };
        0x2::event::emit<VakinhaCreated>(v2);
        0x2::transfer::share_object<Vakinha>(v1);
    }

    public fun donate(arg0: &mut Vakinha, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        assert!(arg2 > 0, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg2, 4);
        if (v0 == arg2) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
        } else {
            0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg3));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        };
        arg0.amount_donated = arg0.amount_donated + arg2;
        let v1 = DonationMade{
            vakinha_id    : 0x2::object::uid_to_address(&arg0.id),
            donor         : 0x2::tx_context::sender(arg3),
            amount        : arg2,
            total_donated : arg0.amount_donated,
        };
        0x2::event::emit<DonationMade>(v1);
    }

    public fun get_balance(arg0: &Vakinha) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_vakinha_info(arg0: &Vakinha) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, u64, u64, bool) {
        (arg0.name, arg0.image_url, arg0.description, arg0.owner, arg0.goal_amount, arg0.amount_donated, arg0.is_active)
    }

    public fun is_goal_reached(arg0: &Vakinha) : bool {
        arg0.amount_donated >= arg0.goal_amount
    }

    public fun withdraw(arg0: &mut Vakinha, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v1 > 0, 3);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v1, arg1), v0);
        let v2 = WithdrawMade{
            vakinha_id : 0x2::object::uid_to_address(&arg0.id),
            owner      : v0,
            amount     : v1,
        };
        0x2::event::emit<WithdrawMade>(v2);
    }

    public fun withdraw_coin(arg0: &mut Vakinha, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v1 > 0, 3);
        arg0.is_active = false;
        let v2 = WithdrawMade{
            vakinha_id : 0x2::object::uid_to_address(&arg0.id),
            owner      : v0,
            amount     : v1,
        };
        0x2::event::emit<WithdrawMade>(v2);
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v1, arg1)
    }

    // decompiled from Move bytecode v6
}

