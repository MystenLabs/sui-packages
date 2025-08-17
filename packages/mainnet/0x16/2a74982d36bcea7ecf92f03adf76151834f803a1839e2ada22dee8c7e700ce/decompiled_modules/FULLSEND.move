module 0x162a74982d36bcea7ecf92f03adf76151834f803a1839e2ada22dee8c7e700ce::FULLSEND {
    struct FULLSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: FULLSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FULLSEND>(arg0, 6, b"Full Send", b"FULLSEND", b"$MANIFEST buys porsches. $FULLSEND is for the aventadors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreibyie2d6dgdiyxhb7s6raek6zzz4h5eh6rxtuj2uivmppjcek4guy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FULLSEND>>(v0, @0xa5f11852c66d81fe289b74600041f13ea29d3b43ebf53db4a5ac2d934effd6b9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FULLSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

