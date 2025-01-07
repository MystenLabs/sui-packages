module 0xf5d4b77a026c70f877e70675ea51c75f1d02b32a90cf34c755dcc23a71400bfd::zos {
    struct ZOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOS>(arg0, 2, b"ZOS", b"Zif On Sui", b"Zos is a meme token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZOS>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

