module 0x14a2c2c14da4c514ddcf91e6bd4da3e31e59e9020eb84f19ac9c45eedb4bf868::mfer {
    struct MFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFER>(arg0, 6, b"MFER", b"Mfer Coin", b"No roadmap. No promises. No team. Just real mfers doing real mfer things.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibq7bkzqbsdnaoosbkbsvbi4hxto37usb2ct33dsiqqtov7jvc5ze")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MFER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

