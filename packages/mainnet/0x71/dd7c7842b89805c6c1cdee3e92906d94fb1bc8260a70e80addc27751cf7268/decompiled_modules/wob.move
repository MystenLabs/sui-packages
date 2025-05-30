module 0x71dd7c7842b89805c6c1cdee3e92906d94fb1bc8260a70e80addc27751cf7268::wob {
    struct WOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOB>(arg0, 6, b"WOB", b"POKE WOB", b"The blue king of bouncebacks is almost here. calm, cool, and about to shake up the meme coin game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqt5kc4frtmdazeijcq3kvssrmehbcaogr5d7mgroyegkms4vvxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

