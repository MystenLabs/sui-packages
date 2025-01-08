module 0x489d2f423a4d1d76a839f91ab0896bc9c80ac9746146d80f9c5d2ec2a921b370::babypepe {
    struct BABYPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPEPE>(arg0, 6, b"BABYPEPE", b"babypepe", b"just a babypepe in sui . tired of the same old doge and cat. Babypepe needs to reshape the success of meme. Babypepe is communit driven . never farm or rug pull. I am just a proposer. The development and growth depend community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736333619932.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

