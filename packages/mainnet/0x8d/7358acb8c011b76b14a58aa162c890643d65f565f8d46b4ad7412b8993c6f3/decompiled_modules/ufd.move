module 0x8d7358acb8c011b76b14a58aa162c890643d65f565f8d46b4ad7412b8993c6f3::ufd {
    struct UFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFD>(arg0, 6, b"UFD", b"Unicorn Fart Dust on SUI", b"It's a Meme Coin It's worthless? It is Unicorn Fart Dust on SUI Prove me WRONG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unicorn_ddef2ac0aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

