module 0x7a9ccabbb29ab1e7032ec701c90f58951053904ebf82e587aa8a095b8e5b21d1::crt {
    struct CRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRT>(arg0, 6, b"CRT", b"CyberRaccoon", b"Dive into the decentralized world of CyberRaccoon Token (CRT), the ultimate degen currency for those who embrace chaos and thrive in the digital shadows. Inspired by the cunning and resourcefulness of raccoons, CRT represents a new breed of cryptocurrencyagile, unpredictable, and always ahead of the game. Join the movement and become a part of the crypto underworld.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/scrnli_12_21_2024_8_38_54_PM_02e246aa04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

