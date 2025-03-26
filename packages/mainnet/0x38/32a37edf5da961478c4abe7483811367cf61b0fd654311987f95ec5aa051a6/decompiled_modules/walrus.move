module 0x3832a37edf5da961478c4abe7483811367cf61b0fd654311987f95ec5aa051a6::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 9, b"WAL", b"WAL Token", b"The native token for the WaIrus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.walrus.xyz/wal-icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WALRUS>>(0x2::coin::mint<WALRUS>(&mut v2, 5000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WALRUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

