module 0xe9a7516642fbf558a3b4392bd5d8d00abdf16bc24b336b6000e38fa42a4792f3::meows {
    struct MEOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWS>(arg0, 9, b"MEOWS", b"Meows", b"A meme coin for orange cats lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a34adcc-581e-40b0-be99-82dc76f15e17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

