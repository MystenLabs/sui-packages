module 0x8fd66d4ddcf93108029b28025bd6411b002b0fcc69b71f58a2c73381ec9d9547::blp {
    struct BLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLP>(arg0, 9, b"BLP", b"BabySuimon LP", b"LP already burn 100%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLP>(&mut v2, 5436792747000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

