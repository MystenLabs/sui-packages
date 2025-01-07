module 0xa014d22e262d6446bac85b66c309e5a78b9c4e95bb8751c6eca2fd848fb7b86c::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"Sui P'Nut the Squirrel", b"Legend has it, Pnut the Squirrel may have left this earthly realm, but his spirit roams the blockchain as a guardian of freedom, happiness, play, and, of course, Bitcoin! P'Nut was never just a squirrel - he was a degen above degens, a legend among meme coins, and a symbol of unbreakable joy. Now, as the eternal protector of our stacks, he blesses us with nutty good luck and Bitcoin blessings from the great beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipnut_cf14ddb02f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

