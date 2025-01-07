module 0xdef8bcdf32046049628a6f7b02465376e268c9a4016613febea7a9ed03dceb8c::suiburg {
    struct SUIBURG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBURG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBURG>(arg0, 6, b"SUIBURG", b"CryptoBurger", b"Very delicious burger with a taste of wealth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ded202ac_de43_46f0_8751_a4de609a4bac_48fd14b846.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBURG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBURG>>(v1);
    }

    // decompiled from Move bytecode v6
}

