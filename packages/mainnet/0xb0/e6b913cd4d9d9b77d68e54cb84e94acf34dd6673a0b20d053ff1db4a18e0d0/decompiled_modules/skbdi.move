module 0xb0e6b913cd4d9d9b77d68e54cb84e94acf34dd6673a0b20d053ff1db4a18e0d0::skbdi {
    struct SKBDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKBDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKBDI>(arg0, 6, b"SKBDI", b"Skibidi Toilet", b"Skibidi Toilet  is a cryptocurrency that has gained attention for its unique origins and lighthearted approach to crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SKIBIDI_8fdf9051cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKBDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKBDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

