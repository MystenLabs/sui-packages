module 0x244a0bab7cb5aa7efa82c50182cb83728dbab01a70d6707364446127c3989a4c::shiyo {
    struct SHIYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIYO>(arg0, 6, b"SHIYO", b"The New Doge", b"$SHIYO is a meme coin that fuses the legendary doge meme power with the lightning fast With a confident, chain wearing Shiba mascot, $SHIYO is here to lead the meme revolution cool, clean, and community-driven.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibr7okmokkbykqbtexh7ony4modgkozmq6utm7uvnevwxadplnxyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIYO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

