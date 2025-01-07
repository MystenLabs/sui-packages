module 0xaf1e4c9e3980554f9987383a7b1a845986d01693e9daf6abad019efc5d137312::hangyodon {
    struct HANGYODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANGYODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANGYODON>(arg0, 6, b"HANGYODON", b"Hangyodon", b"Hangyodon is a nice guy who loves to make others laugh, but has a soft spot and doesn't like being alone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_23_41_32_bbc9c80ee7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANGYODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANGYODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

