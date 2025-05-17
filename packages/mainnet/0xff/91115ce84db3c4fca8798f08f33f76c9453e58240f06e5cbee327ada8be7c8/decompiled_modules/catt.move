module 0xff91115ce84db3c4fca8798f08f33f76c9453e58240f06e5cbee327ada8be7c8::catt {
    struct CATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATT>(arg0, 9, b"vsysf", b"catt", b"sdfgsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

