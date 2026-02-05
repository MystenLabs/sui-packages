module 0xe71fbd8eb3237de910be7e3ae1ef0fc5d0dc1ea08c8b0de24cd3a759a96c084d::flowdesk {
    struct FLOWDESK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLOWDESK>, arg1: 0x2::coin::Coin<FLOWDESK>) {
        0x2::coin::burn<FLOWDESK>(arg0, arg1);
    }

    fun init(arg0: FLOWDESK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOWDESK>(arg0, 6, b"FLOWDESK", b"flowdesk", b"Shares productivity tips and promotes flowdesk productivity tool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2014561128852914176/sW9aeOyk_400x400.jpg#1770274688346250000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOWDESK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOWDESK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLOWDESK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLOWDESK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

