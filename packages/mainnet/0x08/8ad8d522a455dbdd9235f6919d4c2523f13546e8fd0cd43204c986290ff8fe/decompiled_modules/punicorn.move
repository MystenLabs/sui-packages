module 0x88ad8d522a455dbdd9235f6919d4c2523f13546e8fd0cd43204c986290ff8fe::punicorn {
    struct PUNICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNICORN>(arg0, 9, b"PUNICORN", b"PUPUNICORN", b"The pumpiest unicorn evercan fly far far beyond ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d227771d-a7c5-4408-93a1-9e802e76b1fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

