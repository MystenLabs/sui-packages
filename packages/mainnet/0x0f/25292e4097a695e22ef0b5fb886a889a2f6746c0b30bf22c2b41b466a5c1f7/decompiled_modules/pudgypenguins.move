module 0xf25292e4097a695e22ef0b5fb886a889a2f6746c0b30bf22c2b41b466a5c1f7::pudgypenguins {
    struct PUDGYPENGUINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGYPENGUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGYPENGUINS>(arg0, 6, b"PudgyPenguins", b"Pudgy Penguins", b"Spreading good vibes across the meta  http://discord.gg/pudgypenguins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_16_29_05_a2cc8dd110.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGYPENGUINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGYPENGUINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

