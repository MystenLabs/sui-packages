module 0x7114b26500c84bd068580c53cfd6fb4798c037f7755c09ec8eec86bbf045fc46::air {
    struct AIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIR>(arg0, 6, b"AIR", b"AIRINE", b"Airine: A decentralized token designed to streamline and innovate air transport and logistics, leveraging blockchain technology for transparency and efficiency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ec9385c4_ba4a_4edd_8d18_a1fcfc7dc976_55cbccc947.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

