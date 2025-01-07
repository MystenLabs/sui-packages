module 0x382f7661e37225aad717f443296bec28f1c194bf9a7dd0f5a6e7b87a117088a9::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA>(arg0, 6, b"SA", b"SAW", b"Welcome to the game without telegram or x or page. Yes, Satoshi Nakamoto created Bitcoin like this. I created this game without tokens or anything. The best and the one who is not afraid to die. Let the game begin...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a3da8d2b_e8ea_4ecc_978b_e25e45ded03b_42b8326eca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SA>>(v1);
    }

    // decompiled from Move bytecode v6
}

