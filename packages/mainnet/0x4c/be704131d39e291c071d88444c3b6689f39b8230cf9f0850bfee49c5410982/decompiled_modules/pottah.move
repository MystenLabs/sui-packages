module 0x4cbe704131d39e291c071d88444c3b6689f39b8230cf9f0850bfee49c5410982::pottah {
    struct POTTAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTTAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTTAH>(arg0, 6, b"POTTAH", b"HERRY POTTAH", b"Step aside, Muggles. Herry Pottah (POTTAH) is the spellbound meme coin you never knew you needed. Born in the dank dungeons of meme culture and forged in the blockchain halls of Hogwarts, this derpy sorcerer with a slightly-cursed face and a jittery wand is ready to cast a 10x spell on your bags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiecpnlqxgu3cyqr2zpou67j57aptrsaxtuxblgqgdbglgzopoki44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTTAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POTTAH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

