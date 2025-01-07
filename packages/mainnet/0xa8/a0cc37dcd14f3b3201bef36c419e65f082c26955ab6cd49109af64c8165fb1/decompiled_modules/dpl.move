module 0xa8a0cc37dcd14f3b3201bef36c419e65f082c26955ab6cd49109af64c8165fb1::dpl {
    struct DPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPL>(arg0, 9, b"DPL", b"DonPablo", b"King Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2f569f2-1ac1-4787-871b-70a5dba0f021.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

