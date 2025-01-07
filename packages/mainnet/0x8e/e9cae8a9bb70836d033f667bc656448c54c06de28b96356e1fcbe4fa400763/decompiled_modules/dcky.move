module 0x8ee9cae8a9bb70836d033f667bc656448c54c06de28b96356e1fcbe4fa400763::dcky {
    struct DCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKY>(arg0, 9, b"DCKY", b"DuckyDuck", b"Thats meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5892d4a1-5254-4013-b577-5275ac609955.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

