module 0xf0393023939c8d74633fa2ddd0dd31e1f09bf112ad47c8d8342de0698ef77f72::munkiz {
    struct MUNKIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNKIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNKIZ>(arg0, 6, b"MUNKIZ", b"Munki Mola", b"Munki Mola - $MUNKIZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1e3b4aedf8.bin")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNKIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUNKIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

