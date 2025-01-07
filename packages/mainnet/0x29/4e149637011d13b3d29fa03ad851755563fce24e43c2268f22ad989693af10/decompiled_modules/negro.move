module 0x294e149637011d13b3d29fa03ad851755563fce24e43c2268f22ad989693af10::negro {
    struct NEGRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGRO>(arg0, 9, b"negro", b"negro", b"dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEGRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEGRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

