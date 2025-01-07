module 0x8c4a6452a9d70a790de9bea0f744b844c0e2ac64531e86f739a1b01759117ad1::elonx {
    struct ELONX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONX>(arg0, 6, b"ELONX", b"Elon X", b"The coin inspired by Elon Musk's meme-worthy genius and humor! Just like Elon trying to sleep while his mind is buzzing with endless ideas, Elon X is here to disrupt the crypto space with creativity, community, and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2365_be56b9bb93.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONX>>(v1);
    }

    // decompiled from Move bytecode v6
}

