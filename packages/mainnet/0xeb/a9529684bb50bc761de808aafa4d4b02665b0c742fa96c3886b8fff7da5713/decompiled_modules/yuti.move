module 0xeba9529684bb50bc761de808aafa4d4b02665b0c742fa96c3886b8fff7da5713::yuti {
    struct YUTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUTI>(arg0, 6, b"YUTI", b"Yuti Bot", b"The greatest research bot is now officially a community coin/project! YUTI.BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_190622_56dfe0faf7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

