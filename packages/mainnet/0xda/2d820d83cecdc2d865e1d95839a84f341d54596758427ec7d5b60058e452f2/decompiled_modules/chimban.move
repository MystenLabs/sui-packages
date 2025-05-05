module 0xda2d820d83cecdc2d865e1d95839a84f341d54596758427ec7d5b60058e452f2::chimban {
    struct CHIMBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIMBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIMBAN>(arg0, 6, b"ChimBan", b"Chimpanzini bananini", b"Chimpanzini bananini. Balerina chapuccina", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigxv7dit2tvh3st7xzl5v6qsb7va7xhc6p77ip5wbkmzmwfnlkm3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIMBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIMBAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

