module 0x42e877301f21666b049e5f5c2e568e9f13a48a7dbe8de83352f01617275cf181::bx3fish {
    struct BX3FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BX3FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BX3FISH>(arg0, 6, b"bx3FISH", b"bbbFISH", b"bbbFISH. GOAT OF THE SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_2561ff5584.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BX3FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BX3FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

