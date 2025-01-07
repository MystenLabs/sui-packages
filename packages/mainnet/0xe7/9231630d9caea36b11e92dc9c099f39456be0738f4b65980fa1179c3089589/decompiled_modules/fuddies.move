module 0xe79231630d9caea36b11e92dc9c099f39456be0738f4b65980fa1179c3089589::fuddies {
    struct FUDDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDIES>(arg0, 9, b"FUDDIES", b"Fuddies", b"Fuddies", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUDDIES>(&mut v2, 666666666000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDIES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDDIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

