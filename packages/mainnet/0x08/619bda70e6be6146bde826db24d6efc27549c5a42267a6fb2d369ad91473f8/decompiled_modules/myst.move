module 0x8619bda70e6be6146bde826db24d6efc27549c5a42267a6fb2d369ad91473f8::myst {
    struct MYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYST>(arg0, 6, b"Myst", b"Mystardio", b"mystardio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmePtgQAwsY7h8GKswbhYnZT2j9VTr64MF36FKUvUYcA6Z?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MYST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYST>>(v2, @0x8dea104908ddf3eec7d3063b4832d2c6bad3bad618f49fcc3e279909659785ee);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYST>>(v1);
    }

    // decompiled from Move bytecode v6
}

