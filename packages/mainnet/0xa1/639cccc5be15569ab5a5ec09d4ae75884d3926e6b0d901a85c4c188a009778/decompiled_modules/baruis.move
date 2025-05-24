module 0xa1639cccc5be15569ab5a5ec09d4ae75884d3926e6b0d901a85c4c188a009778::baruis {
    struct BARUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARUIS>(arg0, 6, b"BARUIS", b"BARUIS MINT PLAY AND EARN", b"$BARUIS is the utility token of the upcoming Baruis Bomber game in $SUI. Mint, play and earn together with other $SUI holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibyhm5g6mpvqwwatrmooa5kxiqfutwcfyanqwuskxz6rkneyljoqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARUIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

