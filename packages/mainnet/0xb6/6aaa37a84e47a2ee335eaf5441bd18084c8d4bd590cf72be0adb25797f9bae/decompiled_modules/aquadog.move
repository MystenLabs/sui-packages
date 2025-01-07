module 0xb66aaa37a84e47a2ee335eaf5441bd18084c8d4bd590cf72be0adb25797f9bae::aquadog {
    struct AQUADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUADOG>(arg0, 6, b"AQUADOG", b"AQUADOG SUI", x"61717561646f670a4469766520646565702c20666574636820796f7572206761696e732077697468202461717561646f6721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x997da598f32464733b86eead9593bdb3185c752655b6807099a22eb33827c246_adog_adog_0be191b2b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

