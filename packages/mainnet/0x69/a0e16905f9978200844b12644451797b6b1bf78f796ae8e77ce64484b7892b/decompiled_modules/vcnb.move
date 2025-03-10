module 0x69a0e16905f9978200844b12644451797b6b1bf78f796ae8e77ce64484b7892b::vcnb {
    struct VCNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCNB>(arg0, 9, b"VCNB", b"VCNB Token", b"A new token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VCNB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCNB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

