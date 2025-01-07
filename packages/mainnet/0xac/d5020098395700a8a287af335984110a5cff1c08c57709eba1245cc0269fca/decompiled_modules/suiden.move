module 0xacd5020098395700a8a287af335984110a5cff1c08c57709eba1245cc0269fca::suiden {
    struct SUIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEN>(arg0, 6, b"SUIDEN", b"Suiden", b"The national flag of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiden_21fb250e95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

