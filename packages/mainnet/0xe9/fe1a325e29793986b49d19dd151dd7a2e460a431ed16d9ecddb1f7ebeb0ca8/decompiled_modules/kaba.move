module 0xe9fe1a325e29793986b49d19dd151dd7a2e460a431ed16d9ecddb1f7ebeb0ca8::kaba {
    struct KABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABA>(arg0, 6, b"Kaba", b"Japan's Moo Deng", b"(Kaba): Believe it or not, these hippo boats are REAL!  They cruise the waters of Japan, and now they're taking over the internet as the newest meme sensation. Get ready for cuteness overload with  (Kaba)! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_9826fe10fd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

