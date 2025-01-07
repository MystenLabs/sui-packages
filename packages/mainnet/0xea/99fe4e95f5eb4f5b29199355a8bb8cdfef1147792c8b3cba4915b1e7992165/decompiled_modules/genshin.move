module 0xea99fe4e95f5eb4f5b29199355a8bb8cdfef1147792c8b3cba4915b1e7992165::genshin {
    struct GENSHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENSHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENSHIN>(arg0, 9, b"GENSHIN", b"Yae miko", b"Yae Miko is a character in the game Genshin Impact who has Electro elements. He is also known as Guuji Yae and comes from Inazuma. Yae Miko was released in 2022 and became the center of attention because it is similar to Yae Sakura from Honkai Impact 3rd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d78b4b9e-52f0-4d91-8cc4-eaa20d399b3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENSHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENSHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

