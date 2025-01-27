module 0xc0e7b86a6370588be29f93cd61b58e945f49ab5780463b5ab80d34e7c59b1094::riffhare {
    struct RIFFHARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIFFHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIFFHARE>(arg0, 6, b"RIFFHARE", b"RiffHare", b"The rock meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030369_9bf1049e8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIFFHARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIFFHARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

