module 0x23d6685c71ea55336e2d8a222d8e1f7b4735a6d32ca69699343a920af1ea2770::shinx {
    struct SHINX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINX>(arg0, 6, b"SHINX", b"POKEMOON SHINX", b"Shinx evolves into Luxio, who evolves into Luxray.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifiaaaamg6xt5n4hk6nahrt3scjxaqfdtbb76vace4djjjschfc5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHINX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

