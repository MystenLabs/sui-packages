module 0x408f91669415386217c662f6b4f41ddc0661ba3eb560904b03ed272ed923a9f1::rash {
    struct RASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RASH>(arg0, 6, b"Rash", b"Rash Pokemon", b"Rash Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiduj2mfkrju6hfuihbqplj4ifftrdtdba6xiwjpz3e6xbeltuljai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

