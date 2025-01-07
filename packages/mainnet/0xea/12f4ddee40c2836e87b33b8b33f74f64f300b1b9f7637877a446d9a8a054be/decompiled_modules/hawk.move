module 0xea12f4ddee40c2836e87b33b8b33f74f64f300b1b9f7637877a446d9a8a054be::hawk {
    struct HAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWK>(arg0, 6, b"HAWK", b"Hawk Sui", b"Hawk Tuah girl made it to the water chain. Lets Hawk Sui on that thang!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4745_29a69ee4d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

