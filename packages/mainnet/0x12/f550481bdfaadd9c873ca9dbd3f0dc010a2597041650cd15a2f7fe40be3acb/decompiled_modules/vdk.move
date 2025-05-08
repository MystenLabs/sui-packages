module 0x12f550481bdfaadd9c873ca9dbd3f0dc010a2597041650cd15a2f7fe40be3acb::vdk {
    struct VDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDK>(arg0, 6, b"VDK", b"VODKA", b"Created by Vodkababy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiboaky6wfugsfgoo2lfh4v5yiq7epjq3vjjegmvvtq2aqttj34oxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VDK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

