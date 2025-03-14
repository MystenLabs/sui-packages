module 0xc2821d1c5e828a71a5eee0fbb8034550ea62caa8acbaa5d8c49bda249b8c7856::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 9, b"MOODENG", b"Moo Deng ", b"Moo Deng Coin is a memecoin on the Wave Sui blockchain, inspired by a viral pygmy hippo. It has gained rapid popularity and significant price spikes due to social media trends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60a8651b-eb23-4ba3-9683-e1dee91db5c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

