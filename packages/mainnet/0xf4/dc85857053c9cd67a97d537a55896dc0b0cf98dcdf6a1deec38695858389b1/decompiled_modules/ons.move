module 0xf4dc85857053c9cd67a97d537a55896dc0b0cf98dcdf6a1deec38695858389b1::ons {
    struct ONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONS>(arg0, 9, b"ONS", b"OnaSui", b"The project is inspired by history of Japanese concubines of the Nobles. We would like to invite you to the realm of pleasure and dive into the story of our 12 intriguing females and their magical capabilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41983c19-3327-4e29-acc3-4e73252ceb66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

