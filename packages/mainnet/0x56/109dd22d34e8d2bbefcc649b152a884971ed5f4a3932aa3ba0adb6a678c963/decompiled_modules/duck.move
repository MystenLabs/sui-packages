module 0x56109dd22d34e8d2bbefcc649b152a884971ed5f4a3932aa3ba0adb6a678c963::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 9, b"DUCK", b"DuckCoin", b"This meme coin channels Psyduck's quirky charm and mystery, bringing humor and unpredictability to crypto. Each transaction spreads joy, uniting fans in a unique digital journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3c22e9f-a2e8-4dbf-aeac-0a3125d85663.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

