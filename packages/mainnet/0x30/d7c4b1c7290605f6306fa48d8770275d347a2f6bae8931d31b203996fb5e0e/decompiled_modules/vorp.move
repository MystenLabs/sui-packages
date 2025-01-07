module 0x30d7c4b1c7290605f6306fa48d8770275d347a2f6bae8931d31b203996fb5e0e::vorp {
    struct VORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VORP>(arg0, 6, b"VORP", b"Vorp", b"  indomitable human spirit     ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xk_Zlek_L_400x400_1_a90ba62ef8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

