module 0x71113f51d369b020e629d433d9a9dd9a7cecca947e5555fb6967774cdbaa5b06::sadoge {
    struct SADOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADOGE>(arg0, 6, b"SAdoge", b"SuiDoge AI", b"The best #AIDOGE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1087_a0c3dd8858.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

