module 0x8ab92bc2cd353bb45347aabb52e3690fd0ef08f2fe2d746713f540dd0b6753f8::slop {
    struct SLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOP>(arg0, 6, b"slop", b"$slop", b"$slop meme next x100gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-deep-eel-22.mypinata.cloud/ipfs/QmR1gHcEhkXXVwP2PXyQqXhBWq7xgu6q1j4Hbpp7TuSdKR")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLOP>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

