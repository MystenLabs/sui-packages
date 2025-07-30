module 0x9650b51f3e250a5f625221f3cc974fcd25903478d0b24829472ee7450317baa2::demigod {
    struct DEMIGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMIGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMIGOD>(arg0, 6, b"DEMIGOD", b"Demigod on SUI", b"Let's see", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjru2f2dtv2vgp43xurpuhd3mwzbozsivusdwisuk333k2eves3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMIGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEMIGOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

