module 0x114f310f0925bd31cc3050071a3d41f033d8776537760ea414ecedae2b73f0e::moodengai {
    struct MOODENGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENGAI>(arg0, 6, b"MOODENGAI", b"Moodeng AI", b"The aim is to bridge Artificial Intelligence (AI) with Blockchain technology through AI-designed NFTs. Read more in our whitepaper. The adventure awaits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zvv6_Dt_Xg_B_Qodsm_9e475d7846.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

