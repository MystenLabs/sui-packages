module 0xe437a70b86ae99eeb31173feced17bea3f5d4bb05ac240bf145b074768887a73::dcky {
    struct DCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKY>(arg0, 9, b"DCKY", b"DuckyDuck", b"That is meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dcdb743-1df4-4efe-8033-09cf91e8229e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

