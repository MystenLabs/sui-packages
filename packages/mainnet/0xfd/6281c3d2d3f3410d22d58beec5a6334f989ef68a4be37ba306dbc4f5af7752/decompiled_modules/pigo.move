module 0xfd6281c3d2d3f3410d22d58beec5a6334f989ef68a4be37ba306dbc4f5af7752::pigo {
    struct PIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGO>(arg0, 9, b"PIGO", b"Sui Pigo", x"49532054484154204120504550453f20f09f90b820495320544841542041205049473ff09f90b7204954204c4f4f4b53204c494b45204120245049474f2120f09f9388", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmafW8yjJ8KNf2Q3deLsfaVpxLAbHL4f7quVmELT1SBiiH?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIGO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

