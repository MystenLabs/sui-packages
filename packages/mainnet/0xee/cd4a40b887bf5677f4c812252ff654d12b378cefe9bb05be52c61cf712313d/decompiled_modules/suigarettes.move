module 0xeecd4a40b887bf5677f4c812252ff654d12b378cefe9bb05be52c61cf712313d::suigarettes {
    struct SUIGARETTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGARETTES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGARETTES>(arg0, 6, b"SUIGARETTES", b"Suigarettes", b"Entry every meme and chill with $Suigarettes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suigeret_952d741059.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGARETTES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGARETTES>>(v1);
    }

    // decompiled from Move bytecode v6
}

