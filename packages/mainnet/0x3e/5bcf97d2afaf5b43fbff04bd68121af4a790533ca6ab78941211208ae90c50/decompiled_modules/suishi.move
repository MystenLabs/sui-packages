module 0x3e5bcf97d2afaf5b43fbff04bd68121af4a790533ca6ab78941211208ae90c50::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"SUI SHIB", b"Suishib is a SUI blockchain token inspired by the Shiba Inu dog. It aims to leverage the power of decentralized finance (DeFi) and artificial intelligence to create a robust ecosystem for its users. With a focus on community engagement and innovative features, Suishib is set to make waves in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shiba_Inu_in_Sui_cold_blue_token_design_099bc6f725.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

