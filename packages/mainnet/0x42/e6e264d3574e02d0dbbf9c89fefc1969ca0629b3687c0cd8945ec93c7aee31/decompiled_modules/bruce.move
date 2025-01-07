module 0x42e6e264d3574e02d0dbbf9c89fefc1969ca0629b3687c0cd8945ec93c7aee31::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 9, b"BRUCE", b"Sui Bruce Pepe", b"Welcome to Bruce Pepe ready to fight in the meme battle on solana market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/Qmb9s6P1CnRxTu5A6aNHJpDgRnKLB4NcyraC2AimJ4koX2?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRUCE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

