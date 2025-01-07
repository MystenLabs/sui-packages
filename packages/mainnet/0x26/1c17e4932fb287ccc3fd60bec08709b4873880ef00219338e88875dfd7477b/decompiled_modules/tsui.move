module 0x261c17e4932fb287ccc3fd60bec08709b4873880ef00219338e88875dfd7477b::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"TSUI", b"TINY SUI", b"Channel: https://t.me/tinysui_channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/GfwZTVd.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, @0x9bed4125bd0a1048c045325fe2f896c4a0bfd165360caf8be2f6a7e76d601207);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TSUI>(arg0, arg1, @0x9bed4125bd0a1048c045325fe2f896c4a0bfd165360caf8be2f6a7e76d601207, arg2);
    }

    // decompiled from Move bytecode v6
}

