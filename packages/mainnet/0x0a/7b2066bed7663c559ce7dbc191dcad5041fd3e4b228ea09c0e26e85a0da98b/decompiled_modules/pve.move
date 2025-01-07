module 0xa7b2066bed7663c559ce7dbc191dcad5041fd3e4b228ea09c0e26e85a0da98b::pve {
    struct PVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVE>(arg0, 9, b"PVE", b"PVE", b"PVE the Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmQ6NUT6j8ByLkJbKKSTNmqzuxqs3Bgrke2AV5v9MXJeyx?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PVE>(&mut v2, 150000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

