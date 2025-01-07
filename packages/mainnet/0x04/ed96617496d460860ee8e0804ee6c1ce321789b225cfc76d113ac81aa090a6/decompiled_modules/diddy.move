module 0x4ed96617496d460860ee8e0804ee6c1ce321789b225cfc76d113ac81aa090a6::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", b"DIDDY OIL", b"ITS THAT DIDDY BABY OIL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0906_3e177e8b4c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

