module 0x547db7f4d6786ce9b0031fc5e5db322e74db0ed240d6426a28b45ebc72eb8868::lightsui {
    struct LIGHTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGHTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGHTSUI>(arg0, 6, b"LIGHTSUI", b"Light Chain Sui", b"Lightchain AI is a cutting-edge blockchain ecosystem powered by artificial intelligence. Our mission is to revolutionize decentralized applications and governance through innovations like PoI Consensus, the Artificial Intelligence Virtual Machine (AIVM), and a Transparent AI Framework. We aim to create a smarter, more secure, and equitable blockchain ecosystem for all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul59_20250101081344_c6fd0e0ea0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGHTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIGHTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

