module 0x797c416f316fa4cad8c5438875a1012e77b91b86ffff0b9ecbe0d74bdbf04e57::dbuff {
    struct DBUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBUFF>(arg0, 6, b"DBUFF", b"DBUFF ON SUI", x"446f6e616c642042756666206973206865726520746f20717561636b207570206d656d6520636f696e73207769746820736f6d6520736572696f7573207574696c697479200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ka1_Kit1_Z_400x400_c63635a9c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

