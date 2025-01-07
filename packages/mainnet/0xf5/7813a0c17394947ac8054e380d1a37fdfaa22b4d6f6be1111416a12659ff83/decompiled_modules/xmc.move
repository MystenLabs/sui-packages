module 0xf57813a0c17394947ac8054e380d1a37fdfaa22b4d6f6be1111416a12659ff83::xmc {
    struct XMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMC>(arg0, 6, b"XMC", b"Xmas Cat On Sui", b"\"XmasCat ($XMC) is a colorful and humorous meme coin on the Sui blockchain, inspired by images of adorable cats in the Christmas atmosphere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_21_2912ec71e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

