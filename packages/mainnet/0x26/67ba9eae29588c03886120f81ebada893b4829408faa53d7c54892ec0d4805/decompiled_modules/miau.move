module 0x2667ba9eae29588c03886120f81ebada893b4829408faa53d7c54892ec0d4805::miau {
    struct MIAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAU>(arg0, 6, b"MIAU", b"SUITTY", b"The narrative of $michi entering the sui chain! Welcome suitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000055674_8557ee15de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

