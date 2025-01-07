module 0x351630f9df156094f21dec823e654a34ecf93de0dfb99b4a2f5af0515d7b3d96::gwb {
    struct GWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWB>(arg0, 6, b"gwb", b"gwb", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GWB>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

