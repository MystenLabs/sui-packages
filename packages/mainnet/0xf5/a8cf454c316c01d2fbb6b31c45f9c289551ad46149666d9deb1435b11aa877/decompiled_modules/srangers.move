module 0xf5a8cf454c316c01d2fbb6b31c45f9c289551ad46149666d9deb1435b11aa877::srangers {
    struct SRANGERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRANGERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRANGERS>(arg0, 6, b"SRANGERS", b"Sui Rangers", x"2049742773204d6f727068696e2054696d65210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_05_A_s_22_10_18_9e82e82e_32c6c3bbb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRANGERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRANGERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

