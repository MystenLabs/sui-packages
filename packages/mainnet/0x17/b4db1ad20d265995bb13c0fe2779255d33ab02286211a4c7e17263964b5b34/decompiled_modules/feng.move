module 0x17b4db1ad20d265995bb13c0fe2779255d33ab02286211a4c7e17263964b5b34::feng {
    struct FENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENG>(arg0, 6, b"Feng", b"feng sui", b"The only yin yang coin In movepump and that's all you need for a good luck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002548776_1b88ae1243.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

