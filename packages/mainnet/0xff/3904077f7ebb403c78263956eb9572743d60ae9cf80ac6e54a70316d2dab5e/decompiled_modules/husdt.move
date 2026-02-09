module 0xff3904077f7ebb403c78263956eb9572743d60ae9cf80ac6e54a70316d2dab5e::husdt {
    struct HUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSDT>(arg0, 9, b"husdt", b"husdt Coin", b"husdt Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-testnet.haedal.xyz/htoken/husdt.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

