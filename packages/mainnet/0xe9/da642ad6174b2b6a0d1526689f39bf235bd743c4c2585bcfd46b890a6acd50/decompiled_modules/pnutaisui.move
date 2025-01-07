module 0xe9da642ad6174b2b6a0d1526689f39bf235bd743c4c2585bcfd46b890a6acd50::pnutaisui {
    struct PNUTAISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTAISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTAISUI>(arg0, 9, b"PNUTAISUI", b"PNUTAI", b"\"Get ready to crack open the future with PNUTAI! This cutting-edge meme coin combines AI innovation with peanut-themed fun, all on the secure and scalable SUI Network Blockchain. Don't miss out on this nutty adventure!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/719ea9db-eee1-4fc2-88f1-d1a48fd1befe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTAISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTAISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

