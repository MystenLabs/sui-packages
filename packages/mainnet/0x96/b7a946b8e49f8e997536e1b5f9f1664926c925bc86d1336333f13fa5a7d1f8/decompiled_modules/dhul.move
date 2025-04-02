module 0x96b7a946b8e49f8e997536e1b5f9f1664926c925bc86d1336333f13fa5a7d1f8::dhul {
    struct DHUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHUL>(arg0, 9, b"DHUL", b"dyuk", b",iyuf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/395ed2fbb3ecdc80af87020f0548ffa7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

