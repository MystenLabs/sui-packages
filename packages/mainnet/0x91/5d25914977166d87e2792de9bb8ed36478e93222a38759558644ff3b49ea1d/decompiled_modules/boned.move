module 0x915d25914977166d87e2792de9bb8ed36478e93222a38759558644ff3b49ea1d::boned {
    struct BONED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONED>(arg0, 6, b"BONED", b"BASED ON NOTHING EXCEPT DOG", b"BONED is the only meme that stands with no foundation because all it needs is DOG energy. No utility, no promises, just pure unfiltered bark-to-the-moon vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihy6ep7cmgkoxexccwxk4fzusxgxwsmhxp267igb2ldwxx6yih2vq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BONED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

