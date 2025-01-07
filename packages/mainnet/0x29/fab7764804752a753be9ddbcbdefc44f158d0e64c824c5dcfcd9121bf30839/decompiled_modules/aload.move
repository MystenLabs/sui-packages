module 0x29fab7764804752a753be9ddbcbdefc44f158d0e64c824c5dcfcd9121bf30839::aload {
    struct ALOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALOAD>(arg0, 6, b"ALOAD", b"bvlumo", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fewcha_86471a7da2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALOAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

