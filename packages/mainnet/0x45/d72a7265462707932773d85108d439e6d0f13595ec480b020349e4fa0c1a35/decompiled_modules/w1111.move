module 0x45d72a7265462707932773d85108d439e6d0f13595ec480b020349e4fa0c1a35::w1111 {
    struct W1111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: W1111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W1111>(arg0, 6, b"W1111", b"11:11", b"My greatest wish is your happiness and to be by your side. I dont know how much time I have, but I promise that wherever I am, I will always love you. I hope to build my future with you, walk hand in hand with you, and fill our home with every experience and emotion. I love you! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wish_e4e0c33e8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W1111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W1111>>(v1);
    }

    // decompiled from Move bytecode v6
}

