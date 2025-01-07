module 0x2ca766407bce9d63ebfc49544ba918979d6364af2b32c73b25acfd7075c54588::cheburcoin {
    struct CHEBURCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBURCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEBURCOIN>(arg0, 10, b"CHEBURCOIN", b"CHEBURCOIN token", b"The official token of the Cheburcoin project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.cloud.google.com/cheburcoin/cheburcoin.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEBURCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEBURCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHEBURCOIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - 0x2::coin::total_supply<CHEBURCOIN>(arg0), 0);
        0x2::coin::mint_and_transfer<CHEBURCOIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

