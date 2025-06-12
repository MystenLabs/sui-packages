module 0xb2fcbf9c5292371c47b9f8d4e70771ae4af9c2cff2b0a036fbbc2e703af174c7::full {
    struct FULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FULL>(arg0, 6, b"FULL", b"HD", b"FULL HD TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieozljiol3pjckrs7ka4erhybixyn7mpeqyil2ogcbsx434erdyii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FULL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

