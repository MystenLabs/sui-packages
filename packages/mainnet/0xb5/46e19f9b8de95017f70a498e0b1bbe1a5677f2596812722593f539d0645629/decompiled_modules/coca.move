module 0xb546e19f9b8de95017f70a498e0b1bbe1a5677f2596812722593f539d0645629::coca {
    struct COCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCA>(arg0, 9, b"COCA", b"Cocacola", b"heath and good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa1ae97d-09d9-4181-b093-bbae11830442.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

