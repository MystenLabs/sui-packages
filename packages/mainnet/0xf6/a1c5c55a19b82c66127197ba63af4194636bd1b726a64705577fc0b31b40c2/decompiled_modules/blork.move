module 0xf6a1c5c55a19b82c66127197ba63af4194636bd1b726a64705577fc0b31b40c2::blork {
    struct BLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLORK>(arg0, 6, b"Blork", b"Blork Is Fine", b"Blork is here, and he absolutely fine! BLORK is the ultimate meme coin for the chill, the chaotic, and the meme lords of the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreievln2rhc2l7jlv7vv3xuqrvbolo6c5toqt2tesemsrp3e2svnsvq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

