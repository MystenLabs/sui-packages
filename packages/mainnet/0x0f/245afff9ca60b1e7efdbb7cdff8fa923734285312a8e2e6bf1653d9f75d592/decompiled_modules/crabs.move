module 0xf245afff9ca60b1e7efdbb7cdff8fa923734285312a8e2e6bf1653d9f75d592::crabs {
    struct CRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABS>(arg0, 6, b"CRABS", b"crabs", b"crabs  crabs  crabs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_41_31_24a113be08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

