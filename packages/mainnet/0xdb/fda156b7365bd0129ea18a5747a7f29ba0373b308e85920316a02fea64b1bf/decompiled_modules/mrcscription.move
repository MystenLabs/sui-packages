module 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription {
    struct MRCSCRIPTION has drop {
        dummy_field: bool,
    }

    struct MrcScription has store, key {
        id: 0x2::object::UID,
        amount: 0x1::ascii::String,
        mrc_balance: 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        jelly_fish_v: vector<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>,
        ms_types: vector<0x1::ascii::String>,
        ms_collections: 0x2::table::Table<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
    }

    struct Switch has key {
        id: 0x2::object::UID,
        burnable: bool,
    }

    struct SwitchCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwitchOpen has copy, drop {
        dummy_field: bool,
    }

    struct BurnEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
    }

    public fun do_merge(arg0: &mut MrcScription, arg1: MrcScription, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = unwrap(arg1, arg2);
        let v4 = v3;
        let v5 = v2;
        inject_mrc(arg0, v0);
        inject_sui(arg0, v1);
        if (!0x1::vector::is_empty<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&v5)) {
            inject_jelly_fish(arg0, 0x1::vector::pop_back<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&mut v5));
        };
        0x1::vector::destroy_empty<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(v5);
        let v6 = 0x1::vector::length<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v4);
        while (v6 > 0) {
            inject_ms(arg0, 0x1::vector::pop_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v4));
            v6 = v6 - 1;
        };
        0x1::vector::destroy_empty<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v4);
    }

    public fun do_split(arg0: &mut MrcScription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MrcScription {
        let v0 = (arg1 as u128);
        let v1 = (mrc_value(arg0) as u128);
        let v2 = 0x2::coin::take<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&mut arg0.mrc_balance, arg1, arg2);
        let v3 = new_mrc_ins(arg2);
        let v4 = &mut v3;
        inject_mrc(v4, v2);
        arg0.amount = 0x1::ascii::string(mrc_value_to_vectoru8(arg0));
        let v5 = &mut v3;
        inject_sui(v5, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, (((sui_value(arg0) as u128) * v0 / v1) as u64), arg2));
        let v6 = (((jf_value(arg0) as u128) * v0 / v1) as u64);
        if (v6 > 0 && !0x1::vector::is_empty<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&arg0.jelly_fish_v)) {
            let v7 = &mut v3;
            inject_jelly_fish(v7, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::do_split_fd(0x1::vector::borrow_mut<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&mut arg0.jelly_fish_v, 0), v6, arg2));
        };
        let v8 = 0x1::vector::length<0x1::ascii::String>(&arg0.ms_types);
        let v9 = 0;
        while (v8 > 0) {
            let v10 = 0x2::table::borrow_mut<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.ms_collections, *0x1::vector::borrow<0x1::ascii::String>(&arg0.ms_types, v9));
            let v11 = (((0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(v10) as u128) * v0 / v1) as u64);
            if (v11 > 0) {
                let v12 = &mut v3;
                inject_ms(v12, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(v10, v11, arg2));
            };
            v9 = v9 + 1;
            v8 = v8 - 1;
        };
        v3
    }

    public fun accept_jf_payment(arg0: &mut MrcScription, arg1: 0x2::transfer::Receiving<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>) {
        let v0 = 0x2::transfer::public_receive<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&mut arg0.id, arg1);
        inject_jelly_fish(arg0, v0);
    }

    public fun accept_mrc_payment(arg0: &mut MrcScription, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(&mut arg0.id, arg1);
        inject_mrc(arg0, v0);
    }

    public fun accept_ms_payment(arg0: &mut MrcScription, arg1: 0x2::transfer::Receiving<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>) {
        let v0 = 0x2::transfer::public_receive<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.id, arg1);
        inject_ms(arg0, v0);
    }

    public fun accept_sui_payment(arg0: &mut MrcScription, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1);
        inject_sui(arg0, v0);
    }

    public entry fun burn(arg0: MrcScription, arg1: &Switch, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.burnable, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = BurnEvent{
            id     : 0x2::object::id<MrcScription>(&arg0),
            sender : v0,
        };
        0x2::event::emit<BurnEvent>(v1);
        let (v2, v3, v4, v5) = unwrap(arg0, arg2);
        let v6 = v5;
        let v7 = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v0);
        if (!0x1::vector::is_empty<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&v7)) {
            0x2::transfer::public_transfer<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(0x1::vector::pop_back<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&mut v7), v0);
        };
        0x1::vector::destroy_empty<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(v7);
        let v8 = 0x1::vector::length<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v6);
        while (v8 > 0) {
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x1::vector::pop_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v6), v0);
            v8 = v8 - 1;
        };
        0x1::vector::destroy_empty<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v6);
    }

    fun init(arg0: MRCSCRIPTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = new_mrc_ins(arg1);
        0x2::transfer::public_transfer<MrcScription>(v1, v0);
        let v2 = Switch{
            id       : 0x2::object::new(arg1),
            burnable : false,
        };
        0x2::transfer::share_object<Switch>(v2);
        let v3 = SwitchCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SwitchCap>(v3, v0);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"tick"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"amount"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{amount}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::svg::generateSVG(b"mrc-20x", b"transfer", b"MRC", b"{amount}")));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://mrc20.app/"));
        let v8 = 0x2::package::claim<MRCSCRIPTION>(arg0, arg1);
        let v9 = 0x2::display::new_with_fields<MrcScription>(&v8, v4, v6, arg1);
        0x2::display::update_version<MrcScription>(&mut v9);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, v0);
        0x2::transfer::public_transfer<0x2::display::Display<MrcScription>>(v9, v0);
    }

    public fun inject_jelly_fish(arg0: &mut MrcScription, arg1: 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish) {
        if (0x1::vector::is_empty<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&arg0.jelly_fish_v)) {
            0x1::vector::push_back<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&mut arg0.jelly_fish_v, arg1);
        } else {
            0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::do_merge(0x1::vector::borrow_mut<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&mut arg0.jelly_fish_v, 0), arg1);
        };
    }

    public fun inject_mrc(arg0: &mut MrcScription, arg1: 0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>) {
        0x2::coin::put<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&mut arg0.mrc_balance, arg1);
        arg0.amount = 0x1::ascii::string(mrc_value_to_vectoru8(arg0));
    }

    public fun inject_ms(arg0: &mut MrcScription, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription) {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick(&arg1);
        if (!0x2::table::contains<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.ms_collections, v0)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg0.ms_types, v0);
            0x2::table::add<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.ms_collections, v0, arg1);
        } else {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x2::table::borrow_mut<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.ms_collections, v0), arg1);
        };
    }

    public fun inject_sui(arg0: &mut MrcScription, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
    }

    public fun jf_value(arg0: &MrcScription) : u64 {
        if (0x1::vector::is_empty<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&arg0.jelly_fish_v)) {
            0
        } else {
            0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::amount(0x1::vector::borrow<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(&arg0.jelly_fish_v, 0))
        }
    }

    public entry fun merge(arg0: &mut MrcScription, arg1: MrcScription, arg2: &mut 0x2::tx_context::TxContext) {
        do_merge(arg0, arg1, arg2);
    }

    public fun mrc_value(arg0: &MrcScription) : u64 {
        0x2::balance::value<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&arg0.mrc_balance)
    }

    public fun mrc_value_to_vectoru8(arg0: &MrcScription) : vector<u8> {
        0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::string_utils::u64FloatToVectorU8Cut(mrc_value(arg0), 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::mrc_decimals())
    }

    public fun ms_types(arg0: &MrcScription) : vector<0x1::ascii::String> {
        arg0.ms_types
    }

    public fun ms_value(arg0: &MrcScription, arg1: vector<u8>) : u64 {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        let v0 = 0x1::ascii::string(arg1);
        if (0x2::table::contains<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.ms_collections, v0)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x2::table::borrow<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.ms_collections, v0))
        } else {
            0
        }
    }

    public fun ms_value_vec(arg0: &MrcScription) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::length<0x1::ascii::String>(&arg0.ms_types);
        let v2 = 0;
        while (v1 > 0) {
            0x1::vector::push_back<u64>(&mut v0, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x2::table::borrow<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.ms_collections, *0x1::vector::borrow<0x1::ascii::String>(&arg0.ms_types, v2))));
            v1 = v1 - 1;
            v2 = v2 + 1;
        };
        v0
    }

    fun new_mrc_ins(arg0: &mut 0x2::tx_context::TxContext) : MrcScription {
        MrcScription{
            id             : 0x2::object::new(arg0),
            amount         : 0x1::ascii::string(b"0"),
            mrc_balance    : 0x2::balance::zero<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(),
            sui_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            jelly_fish_v   : 0x1::vector::empty<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>(),
            ms_types       : 0x1::vector::empty<0x1::ascii::String>(),
            ms_collections : 0x2::table::new<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg0),
        }
    }

    public entry fun open_switch(arg0: SwitchCap, arg1: &mut Switch) {
        let SwitchCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        arg1.burnable = true;
        let v1 = SwitchOpen{dummy_field: false};
        0x2::event::emit<SwitchOpen>(v1);
    }

    public(friend) fun pay(arg0: &mut MrcScription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC> {
        arg0.amount = 0x1::ascii::string(mrc_value_to_vectoru8(arg0));
        0x2::coin::take<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&mut arg0.mrc_balance, arg1, arg2)
    }

    public entry fun split(arg0: &mut MrcScription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = do_split(arg0, arg1, arg2);
        0x2::transfer::public_transfer<MrcScription>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun sui_value(arg0: &MrcScription) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    fun unwrap(arg0: MrcScription, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>, 0x2::coin::Coin<0x2::sui::SUI>, vector<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::jellyfish::JellyFish>, vector<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>) {
        let MrcScription {
            id             : v0,
            amount         : _,
            mrc_balance    : v2,
            sui_balance    : v3,
            jelly_fish_v   : v4,
            ms_types       : v5,
            ms_collections : v6,
        } = arg0;
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x1::vector::empty<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>();
        let v10 = 0x1::vector::length<0x1::ascii::String>(&v8);
        while (v10 > 0) {
            0x1::vector::push_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v9, 0x2::table::remove<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut v7, 0x1::vector::pop_back<0x1::ascii::String>(&mut v8)));
            v10 = v10 - 1;
        };
        0x2::table::destroy_empty<0x1::ascii::String, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v7);
        0x2::object::delete(v0);
        (0x2::coin::from_balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(v2, arg1), 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg1), v4, v9)
    }

    // decompiled from Move bytecode v6
}

