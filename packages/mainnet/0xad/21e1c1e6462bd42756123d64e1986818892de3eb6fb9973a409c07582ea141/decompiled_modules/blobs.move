module 0xad21e1c1e6462bd42756123d64e1986818892de3eb6fb9973a409c07582ea141::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBS>(arg0, 6, b"Blobs", b"Blobs Real", b"$Blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. A legendary character inspired by Matt Furie's first illustration, capturing his unique humor and surreal vision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731427717341.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

