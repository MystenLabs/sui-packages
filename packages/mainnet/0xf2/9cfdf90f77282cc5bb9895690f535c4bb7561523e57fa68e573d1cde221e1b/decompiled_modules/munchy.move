module 0xf29cfdf90f77282cc5bb9895690f535c4bb7561523e57fa68e573d1cde221e1b::munchy {
    struct MUNCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNCHY>(arg0, 6, b"Munchy", b"MunchySui", b"Hungry for gains?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_072745995_97f32704a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNCHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUNCHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

