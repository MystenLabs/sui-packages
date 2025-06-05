module 0x2fad15277618d10c64c59c9e1f3d458dd0d2dc83cbe76c2eeddbef13e9c7b330::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"Apechu", b"Apechu On SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifubgiptcsuwlvcx5caohx2xbxtm2tj33xljxli6n4ceewpznpghu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

