module 0x3959bf68e66396e4f3437f5026bd0771c82dda5acb06811106125e007f5d8c01::pashacat {
    struct PASHACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PASHACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PASHACAT>(arg0, 9, b"PASHACAT", b"PASHA", b"Awesome cat that i've ever seen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8ace4bd-38c5-40a1-92ea-7875292de996.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PASHACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PASHACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

