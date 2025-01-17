module 0xc1e32533b4a69971bfc789aed33a44c009341079570b1a1647827a25b3e11002::mct {
    struct MCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCT>(arg0, 6, b"MCT", b"Mad Cat", b"I asked for tuna, not a job at the Krusty Krab.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Spongebob_95155c75c6.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

