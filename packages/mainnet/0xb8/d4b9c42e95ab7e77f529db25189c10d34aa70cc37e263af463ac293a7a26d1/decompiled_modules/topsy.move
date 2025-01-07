module 0xb8d4b9c42e95ab7e77f529db25189c10d34aa70cc37e263af463ac293a7a26d1::topsy {
    struct TOPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPSY>(arg0, 6, b"TOPSY", b"Sui Topsy", x"57656c636f6d6520746f2074686520546f70737920436f6d6d756e69747921200a47657420726561647920666f7220736f6d657468696e6720687567652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015820_3647915f8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOPSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

