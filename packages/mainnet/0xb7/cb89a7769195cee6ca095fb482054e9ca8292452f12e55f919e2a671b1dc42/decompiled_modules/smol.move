module 0xb7cb89a7769195cee6ca095fb482054e9ca8292452f12e55f919e2a671b1dc42::smol {
    struct SMOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOL>(arg0, 9, b"SMOL", b"SMALL", b"he's so smol wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMOL>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

