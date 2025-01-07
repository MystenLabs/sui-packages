module 0xf4f397eafb5cff65e32d4ce57a86cfae5df65aa4c01e7a2fbc1dc377e3078c15::melt {
    struct MELT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELT>(arg0, 6, b"MELT", b"Melt on Sui", b"Crypto meme on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_FU_Fr_I_Cf_400x400_73f081afe4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELT>>(v1);
    }

    // decompiled from Move bytecode v6
}

