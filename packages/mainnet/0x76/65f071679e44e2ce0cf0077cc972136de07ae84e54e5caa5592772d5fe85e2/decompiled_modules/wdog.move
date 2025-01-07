module 0x7665f071679e44e2ce0cf0077cc972136de07ae84e54e5caa5592772d5fe85e2::wdog {
    struct WDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOG>(arg0, 6, b"WDOG", b"WalrusDog", b"A walrus or a dog, I can't tell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_02_17_30_40_A_realistic_photo_of_a_dog_sitting_on_a_living_room_carpet_wearing_a_simple_walrus_costume_The_costume_includes_soft_homemade_looking_tusks_and_fli_a72a3606da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

