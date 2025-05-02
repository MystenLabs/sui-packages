module 0x4e14c1a959d8b6540d71708a97bd8672245614074d07ad7b2233baf43cc43342::hbibi {
    struct HBIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBIBI>(arg0, 6, b"HBIBI", b"HABIBI", b"HABIBI, THIS AIN'T JUST A COIN, IT'S A LIFESTYLE WELCOME TO SUI HABIBI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhxb5vfm6sp3bian2k47tudn45pwbcy74keh725xhonbeoczd3xy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HBIBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

