module 0x8f156e22447f1e111e9be484ad67e4588080a952f54199a6801bdc77259bdd61::akamaru {
    struct AKAMARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKAMARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKAMARU>(arg0, 6, b"Akamaru", b"Akamaru Sui", b"Welcome to Akamaru! Were an awesome community-driven meme token on a mission to bring our holders amazing profits and great times!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/akamaru_5844276294.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKAMARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKAMARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

