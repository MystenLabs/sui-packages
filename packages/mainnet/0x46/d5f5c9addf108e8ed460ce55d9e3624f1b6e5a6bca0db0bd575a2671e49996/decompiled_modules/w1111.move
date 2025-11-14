module 0x46d5f5c9addf108e8ed460ce55d9e3624f1b6e5a6bca0db0bd575a2671e49996::w1111 {
    struct W1111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: W1111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W1111>(arg0, 6, b"W1111", b"11:11", b"My greatest wish is your happiness and to be by your side. I dont know how much time I have, but I promise that wherever I am, I will always love you. I hope to build my future with you, walk hand in hand with you, and fill our home with every experience and emotion. I love you! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wish_fedff18277.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W1111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W1111>>(v1);
    }

    // decompiled from Move bytecode v6
}

