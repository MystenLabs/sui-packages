module 0x28f25d749f12db6fab66995f495e415dd407065801561580aeda0c1744f5e97d::lama {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 6, b"LAMA", b"LAMA-CTO", b"Lama, a rebellious and disdainful lama, determined to be a meaningful, fun, and fair meme! We introduce Lama to embody the lama spirit, expressing disdain and mockery towards the absurdity of the current meme market. Lama symbolizes the rebellious and free spirit of the llama community, embracing a carefree and nonchalant attitude towards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Md_MF_3_Qn6_400x400_eac6c85233.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

