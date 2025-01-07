module 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox {
    struct KARTBOX has drop {
        dummy_field: bool,
    }

    struct KartBoxRepo has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>,
    }

    struct KartBox has store, key {
        id: 0x2::object::UID,
        init_value: u64,
        period: u64,
        type: 0x1::string::String,
        color: 0x1::string::String,
        balance: 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct BoxSwitch has key {
        id: 0x2::object::UID,
        free_time: u64,
    }

    struct FreeCap has store, key {
        id: 0x2::object::UID,
    }

    struct Withdraw has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct SaveIntoRepo has copy, drop {
        amount: u64,
    }

    struct WithdrawRepo has copy, drop {
        amount: u64,
    }

    struct Mint has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public entry fun split(arg0: &mut KartBox, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = do_split(arg0, arg1, arg2);
        0x2::transfer::public_transfer<KartBox>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun burn(arg0: KartBox, arg1: &BoxSwitch, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_burn(arg0, arg1, arg2, arg3);
    }

    public fun current_value(arg0: &KartBox) : u64 {
        0x2::balance::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&arg0.balance)
    }

    public fun do_burn(arg0: KartBox, arg1: &BoxSwitch, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        withdraw_from_kartbox(v0, arg1, arg2, arg3);
        assert!(0x2::balance::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&arg0.balance) == 0, 4);
        let KartBox {
            id         : v1,
            init_value : _,
            period     : _,
            type       : _,
            color      : _,
            balance    : v6,
        } = arg0;
        0x2::balance::destroy_zero<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(v6);
        0x2::object::delete(v1);
    }

    public fun do_merge(arg0: &mut KartBox, arg1: KartBox) {
        assert!(arg0.type == arg1.type, 3);
        arg0.init_value = arg0.init_value + arg1.init_value;
        let KartBox {
            id         : v0,
            init_value : _,
            period     : _,
            type       : _,
            color      : _,
            balance    : v5,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg0.balance, v5);
    }

    public fun do_mint(arg0: &MintCap, arg1: &mut KartBoxRepo, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : KartBox {
        assert!(1 <= arg3 && arg3 <= 4, 2);
        let v0 = new_kartbox(0x2::balance::split<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg1.balance, arg2), arg4);
        v0.period = arg3 * 15552000000;
        if (arg3 == 1) {
            v0.type = 0x1::string::utf8(b"I");
            v0.color = 0x1::string::utf8(b"0000FF");
        };
        if (arg3 == 2) {
            v0.type = 0x1::string::utf8(b"II");
            v0.color = 0x1::string::utf8(b"9644C2");
        };
        if (arg3 == 3) {
            v0.type = 0x1::string::utf8(b"III");
            v0.color = 0x1::string::utf8(b"FF922D");
        };
        if (arg3 == 4) {
            v0.type = 0x1::string::utf8(b"IV");
            v0.color = 0x1::string::utf8(b"E6B422");
        };
        v0
    }

    public fun do_split(arg0: &mut KartBox, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : KartBox {
        assert!(0 < arg1 && arg1 < arg0.init_value, 5);
        arg0.init_value = arg0.init_value - arg1;
        let v0 = new_kartbox(0x2::balance::split<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg0.balance, (((0x2::balance::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&arg0.balance) as u128) * (arg1 as u128) / (arg0.init_value as u128)) as u64)), arg2);
        v0.init_value = arg1;
        v0.type = arg0.type;
        v0.period = arg0.period;
        v0.color = arg0.color;
        v0
    }

    public entry fun freebox(arg0: FreeCap, arg1: &mut BoxSwitch, arg2: &0x2::clock::Clock) {
        arg1.free_time = 0x2::clock::timestamp_ms(arg2);
        let FreeCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun get_remain_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg1 + arg2;
        if (arg3 >= v0) {
            0
        } else {
            ((((v0 - arg3) as u128) * (arg0 as u128) / (arg2 as u128)) as u64)
        }
    }

    fun init(arg0: KARTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"KartBox"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::ks_svg::generateboxSVG(b"{color}")));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://karmapi.ai/"));
        let v5 = 0x2::package::claim<KARTBOX>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<KartBox>(&v5, v1, v3, arg1);
        0x2::display::update_version<KartBox>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<KartBox>>(v6, v0);
        let v7 = KartBoxRepo{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(),
        };
        0x2::transfer::share_object<KartBoxRepo>(v7);
        let v8 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v8, v0);
        let v9 = BoxSwitch{
            id        : 0x2::object::new(arg1),
            free_time : 0,
        };
        0x2::transfer::share_object<BoxSwitch>(v9);
        let v10 = FreeCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<FreeCap>(v10, v0);
    }

    public fun init_value(arg0: &KartBox) : u64 {
        arg0.init_value
    }

    public fun inject_kartcoin_to_kartbox(arg0: &mut KartBox, arg1: 0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>) {
        0x2::coin::put<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg0.balance, arg1);
    }

    public entry fun inject_kartcoin_to_kartboxrepo(arg0: &MintCap, arg1: &mut KartBoxRepo, arg2: 0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>) {
        let v0 = SaveIntoRepo{amount: 0x2::coin::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&arg2)};
        0x2::event::emit<SaveIntoRepo>(v0);
        0x2::coin::put<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg1.balance, arg2);
    }

    public entry fun merge(arg0: &mut KartBox, arg1: KartBox) {
        do_merge(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &MintCap, arg1: &mut KartBoxRepo, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = do_mint(arg0, arg1, arg2, arg3, arg5);
        let v1 = Mint{
            id        : 0x2::object::id<KartBox>(&v0),
            recipient : arg4,
            amount    : arg2,
        };
        0x2::event::emit<Mint>(v1);
        0x2::transfer::public_transfer<KartBox>(v0, arg4);
    }

    fun new_kartbox(arg0: 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>, arg1: &mut 0x2::tx_context::TxContext) : KartBox {
        KartBox{
            id         : 0x2::object::new(arg1),
            init_value : 0x2::balance::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&arg0),
            period     : 0,
            type       : 0x1::string::utf8(b"None"),
            color      : 0x1::string::utf8(b"White"),
            balance    : arg0,
        }
    }

    public fun repo_value(arg0: &KartBoxRepo) : u64 {
        0x2::balance::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&arg0.balance)
    }

    public entry fun withdraw_from_kartbox(arg0: &mut KartBox, arg1: &BoxSwitch, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0 < arg1.free_time && arg1.free_time < v0, 1);
        let v1 = 0x2::balance::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&arg0.balance) - get_remain_value(arg0.init_value, arg1.free_time, arg0.period, v0);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(0x2::coin::take<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg0.balance, v1, arg3), v2);
        let v3 = Withdraw{
            id     : 0x2::object::id<KartBox>(arg0),
            sender : v2,
            amount : v1,
        };
        0x2::event::emit<Withdraw>(v3);
    }

    public entry fun withdraw_from_kartboxrepo(arg0: &MintCap, arg1: &mut KartBoxRepo, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::take<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg1.balance, arg2, arg3);
        let v1 = WithdrawRepo{amount: 0x2::coin::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&v0)};
        0x2::event::emit<WithdrawRepo>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

