module 0xff2366c8cd0ded8211f7b629890c03c377a3fd0a904fe8f8d486964c2af2385b::jeffy {
    struct JEFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEFFY>(arg0, 6, b"JEFFY", b"JeffyZoos", x"48657920596f75200a54686973206973200a53756920736561736f6e0a41726520596f75205265616479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_0d14b9d733.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

