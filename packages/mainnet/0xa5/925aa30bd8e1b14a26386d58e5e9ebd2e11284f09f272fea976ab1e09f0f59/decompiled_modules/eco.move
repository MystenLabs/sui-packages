module 0xa5925aa30bd8e1b14a26386d58e5e9ebd2e11284f09f272fea976ab1e09f0f59::eco {
    struct ECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECO>(arg0, 9, b"ECO", b"EcoVerse", b"EcoVerse (ECO) is a cryptocurrency token focused on environmental sustainability and eco-friendly initiatives. The token aims to support and incentivize green projects, from reforestation and renewable energy to carbon footprint reduction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39177532-f271-4a1e-ab0f-68802de8b69d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

