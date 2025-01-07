module 0x66d87c7d84c0b1cc5f78406c93084554943b682edd4f1ad5711562dd3aff3a62::spongebook {
    struct SPONGEBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGEBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGEBOOK>(arg0, 6, b"SpongeBook", b"Sponge Book", x"54686520736d6172746573742076657273696f6e206f6620746865206d617374657220636865662066726f6d2074686520626f74746f6d206f66207468652073656121202453706f6e6765426f6f6b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_06_A_s_01_37_28_53fa7306_1028a90f4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGEBOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGEBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

