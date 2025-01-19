module 0x20b3dbf5ebb066854f537fa0d4b48bfe7bcf9e45b47c169edbcac06c7aaff737::triumph {
    struct TRIUMPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIUMPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIUMPH>(arg0, 6, b"TRIUMPH", b"TRUMP TRIUMPH", b"$TRIUMPH on Sui - the future is ours! TRUMP rises to reclaim leadership, so does $TRIUMPH, the token that embodies victory and power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027287_4a27969a39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIUMPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIUMPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

