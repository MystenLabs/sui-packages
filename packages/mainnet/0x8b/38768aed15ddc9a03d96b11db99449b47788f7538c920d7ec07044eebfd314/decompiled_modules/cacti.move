module 0x8b38768aed15ddc9a03d96b11db99449b47788f7538c920d7ec07044eebfd314::cacti {
    struct CACTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTI>(arg0, 6, b"CACTI", b"Cactuar", b"Attacking random strangers in Kashkabald Desert", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731599756061.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CACTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

