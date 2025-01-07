module 0x7d7cbbf0caf4b49b7edc795f8fa32fa7a731f0bb13ebc594a681033006ee94e1::rnii {
    struct RNII has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RNII>(arg0, 6, b"RNII", b"Rodrini", b"Ballon D'or 2024 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rinii_coin_ea4e81392a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RNII>>(v1);
    }

    // decompiled from Move bytecode v6
}

