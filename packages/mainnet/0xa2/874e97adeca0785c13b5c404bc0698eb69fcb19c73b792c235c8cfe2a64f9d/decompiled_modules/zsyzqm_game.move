module 0xa2874e97adeca0785c13b5c404bc0698eb69fcb19c73b792c235c8cfe2a64f9d::zsyzqm_game {
    struct BONUS_POOL<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: u8,
        zsyzqm_choice: u8,
        result: 0x1::string::String,
    }

    entry fun create_pool_inner<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BONUS_POOL<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<BONUS_POOL<T0>>(v0);
    }

    fun get_random_number(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % ((5 as u64) + 1)) as u8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun play<T0>(arg0: u8, arg1: &0x2::clock::Clock, arg2: &mut BONUS_POOL<T0>, arg3: &mut 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_random_number(arg1);
        let (v1, v2) = if (v0 == arg0) {
            (x"436f6e67726174756c6174696f6e73206f6e206775657373696e6720746865207269676874206e756d6265722c20796f752061726520676f696e6720746f2067657420616c6c2074686520676f6c6420636f696e7320696e20746865207072697a6520706f6f6c2120506c6561736520636865636b20796f75722077616c6c6574f09f9884", true)
        } else {
            (x"556e666f7274756e6174656c792c20796f752772652077726f6e672e20596f75276c6c206861766520746f20706179206120636f696e20696e746f2074686520706f6f6cf09f9294", false)
        };
        let v3 = GamingResultEvent{
            is_win        : v2,
            your_choice   : arg0,
            zsyzqm_choice : v0,
            result        : 0x1::string::utf8(v1),
        };
        0x2::event::emit<GamingResultEvent>(v3);
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.balance), arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg3, 1, arg4)));
        };
    }

    // decompiled from Move bytecode v6
}

