module 0xeb8481af03b29b805dedfab4fa12fcb8f143b966af720bd2a96ab6ff659813e6::vance {
    struct VANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANCE>(arg0, 9, b"VANCE", b"JD VANCE", b"JD VANCE: THE ONLY OFFICIAL $VANCE COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQPQAnXDgYexGzvyCvhgRF8DH95znYrbiY4sXnoyvKkQ2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VANCE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VANCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANCE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

