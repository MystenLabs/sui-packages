module 0x7037452ea23d3d15be2e436114e4102d3e8478679c187abe38d5cd1b6bde4638::paolo {
    struct PAOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAOLO>(arg0, 6, b"paolo", b"paolo", b"paolo is a chef fr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qmb7ESDLLZmKcJyPmtHz8cegvsZRF8bUcYuWs4ySVHj2m8?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAOLO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAOLO>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

