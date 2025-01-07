module 0x4783f085f4d468a6489c8e4e46f81074ee905b2b5c36175b7bf445a9203954fa::cbdc {
    struct CBDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBDC>(arg0, 6, b"CBDC", b"CBDC69i", b"CBDC69i is a digital version of a countrys fiat currency, issued by its central bank. A humorously satirical meme based on the symbol $CBDC, driven by the humorous belief that higher numbers signify greater success. In the realm of unique meme stocks, CBDC69i a new form of money that exists only in digital form. Instead of printing money, the central bank issues widely accessible digital coins so that digital transactions and transfers become simple. Efforts towards CBDC grow all over the world for many reasons., with 69i representing a symbol of financial power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/691_cf8387d288.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

