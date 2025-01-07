module 0xa9111425870b53e708564c206934b03a1a21745b4f8d5d92b15388eacd89b446::kok {
    struct KOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOK>(arg0, 6, b"KOK", b"King Of King", b"Pepe, once the green frog everyone knew, felt a shift deep inside. Tired of being just another meme, he sought transformation. One fateful day, Pepe plunged into the sacred waters of the crypto realm, and as he emerged, his skin turned a brilliant blue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I4_Km37i_U_400x400_daf6b6ac1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

