module 0xd8385055af893ff0a50c280fa49d7c2efaa6df502be41268a322301d1940b0c7::fraug {
    struct FRAUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRAUG>(arg0, 6, b"FRAUG", b"Fraug", b"FraugOnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fraug_99b0dfb7d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRAUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

