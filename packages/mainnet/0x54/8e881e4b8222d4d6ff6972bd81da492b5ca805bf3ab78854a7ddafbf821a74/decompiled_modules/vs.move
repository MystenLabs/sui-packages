module 0x548e881e4b8222d4d6ff6972bd81da492b5ca805bf3ab78854a7ddafbf821a74::vs {
    struct VS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VS>(arg0, 6, b"Vs", b"Harris VS Trump", b"Harris VS Trump 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0385_2_e4d2a84fb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VS>>(v1);
    }

    // decompiled from Move bytecode v6
}

