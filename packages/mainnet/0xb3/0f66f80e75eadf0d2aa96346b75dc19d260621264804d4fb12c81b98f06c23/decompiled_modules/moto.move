module 0xb30f66f80e75eadf0d2aa96346b75dc19d260621264804d4fb12c81b98f06c23::moto {
    struct MOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTO>(arg0, 6, b"MOTO", b"Sui Moto", b"MOTO will be the next mascot of Sui, riding the waves and diving into the beautiful depths of the sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_77_2c30984d56.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

