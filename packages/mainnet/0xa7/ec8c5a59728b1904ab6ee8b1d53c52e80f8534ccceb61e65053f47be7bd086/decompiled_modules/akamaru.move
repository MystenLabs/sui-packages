module 0xa7ec8c5a59728b1904ab6ee8b1d53c52e80f8534ccceb61e65053f47be7bd086::akamaru {
    struct AKAMARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKAMARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKAMARU>(arg0, 6, b"AKAMARU", b"Sui Akamaru", b"Welcome to Akamaru! Were an awesome community-driven meme token on a mission to bring our holders amazing profits and great times!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/akamaru_0ef3d165c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKAMARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKAMARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

