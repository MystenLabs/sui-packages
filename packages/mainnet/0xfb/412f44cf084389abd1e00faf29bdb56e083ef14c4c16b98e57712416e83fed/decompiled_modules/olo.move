module 0xfb412f44cf084389abd1e00faf29bdb56e083ef14c4c16b98e57712416e83fed::olo {
    struct OLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLO>(arg0, 6, b"OLO", b"Olo The Croc", b"$OLO is a meme-driven utility token built on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiccjwsymyne2pblamvxmroyfxinq4tg4nono3uw5eymc5yl5zhlpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

