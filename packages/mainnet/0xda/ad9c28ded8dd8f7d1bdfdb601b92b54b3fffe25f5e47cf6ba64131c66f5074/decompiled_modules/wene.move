module 0xdaad9c28ded8dd8f7d1bdfdb601b92b54b3fffe25f5e47cf6ba64131c66f5074::wene {
    struct WENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENE>(arg0, 9, b"WENE", b"WINCAT", b"WINCAT is a meme create for the wellbeing of the community and all we will do is for the community and community ALONE..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff054303-18f9-4201-aab4-37added6498c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

