module 0x24d0a9ebf328ea124a60a3ab278e0fb7704df504efc14f0e00664a642ec998d6::spearl {
    struct SPEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEARL>(arg0, 6, b"sPEARL", b"SUI Pearl", b"Sui Pearl is more than just a cryptocurrency; it's a vibrant community-driven project that aims to bring smiles, laughter, and reward to it holders Sui pearl symbolizes growth, positivity, and a mindset to build  towards a brighter future in the crypto space. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_15_32_15_2ef67e7719.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

