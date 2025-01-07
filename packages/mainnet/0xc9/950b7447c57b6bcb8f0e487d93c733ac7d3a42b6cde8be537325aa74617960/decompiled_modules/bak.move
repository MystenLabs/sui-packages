module 0xc9950b7447c57b6bcb8f0e487d93c733ac7d3a42b6cde8be537325aa74617960::bak {
    struct BAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAK>(arg0, 9, b"BAK", b"Baki", b"$BAK is the BAKI coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

