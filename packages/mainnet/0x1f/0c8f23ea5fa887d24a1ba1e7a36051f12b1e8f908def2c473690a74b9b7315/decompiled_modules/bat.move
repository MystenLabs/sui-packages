module 0x1f0c8f23ea5fa887d24a1ba1e7a36051f12b1e8f908def2c473690a74b9b7315::bat {
    struct BAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAT>(arg0, 6, b"BAT", b"Batman", b"I'AM BATMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib22scjz5qbcnxdt5sxga3sdwwhd3nzvrb3q6qb7ktbgkskhg5sq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

