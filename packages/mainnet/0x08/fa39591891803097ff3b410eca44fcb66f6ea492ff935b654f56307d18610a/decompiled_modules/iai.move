module 0x8fa39591891803097ff3b410eca44fcb66f6ea492ff935b654f56307d18610a::iai {
    struct IAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAI>(arg0, 6, b"IAI", b"Intellectus AI", b"Intellectus AI makes science, technology, and crypto-powered tools simple and fun. With it, you can explore creative ideas, solve problems, and even create your own AI-powered characters. Whether you're into gaming, NFTs, or just want to dive into the world of crypto and AI, Intellectus AI is here to make it easy and exciting for you to get started and shine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yarno84_Hydrobiowomen_Character_Elegant_Minimal_cosmos_female_c_77ce5d32_f520_4f3e_a7e0_8121ade85d67_1_2ea0e4ff8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

