module 0xa8b716b052af18a83af69ea4cf1716f526d2db1235918480cf16f2ab95084f56::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 9, b"MAX", b"Chinese Max 2025", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcjWaAbBT1p9KSLhBfei1eiuNH8KBpXf8sjPyK7dKcnEC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

