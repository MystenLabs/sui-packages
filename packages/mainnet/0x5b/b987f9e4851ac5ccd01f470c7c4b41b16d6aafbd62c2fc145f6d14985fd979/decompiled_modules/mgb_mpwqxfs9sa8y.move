module 0x5bb987f9e4851ac5ccd01f470c7c4b41b16d6aafbd62c2fc145f6d14985fd979::mgb_mpwqxfs9sa8y {
    struct MGB_MPWQXFS9SA8Y has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGB_MPWQXFS9SA8Y, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGB_MPWQXFS9SA8Y>(arg0, 9, b"MGB", b"MANCHURIANBETRAYAL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmWU1b7QvEj9B6XxmTnPpCSfXoVqwkUTZ7LsbRV6tEEG6B")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGB_MPWQXFS9SA8Y>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGB_MPWQXFS9SA8Y>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

