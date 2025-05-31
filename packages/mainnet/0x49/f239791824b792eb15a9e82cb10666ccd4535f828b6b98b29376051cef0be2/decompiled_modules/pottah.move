module 0x49f239791824b792eb15a9e82cb10666ccd4535f828b6b98b29376051cef0be2::pottah {
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

