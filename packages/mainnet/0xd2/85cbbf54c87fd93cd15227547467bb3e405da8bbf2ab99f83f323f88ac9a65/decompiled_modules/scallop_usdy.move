module 0xd285cbbf54c87fd93cd15227547467bb3e405da8bbf2ab99f83f323f88ac9a65::scallop_usdy {
    struct SCALLOP_USDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_USDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_USDY>(arg0, 6, b"sUSDY", b"sUSDY", b"Scallop interest-bearing token for USDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://v4kpvw5rr2kprz4echmm33xktmu4lu7kh3qncwrw7xvzdipatkya.arweave.net/rxT627GOlPjnhBHYze7qmynF0-o-4NFaNv3rkaHgmrA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_USDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_USDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

