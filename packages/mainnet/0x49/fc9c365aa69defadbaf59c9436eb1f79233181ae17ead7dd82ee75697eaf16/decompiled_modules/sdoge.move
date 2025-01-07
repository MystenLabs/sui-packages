module 0x49fc9c365aa69defadbaf59c9436eb1f79233181ae17ead7dd82ee75697eaf16::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 9, b"SDOGE", b"SAFEDOGE", b"dogs should be protected in Vietnam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec14a234-e942-417a-a003-73cd991d1dd5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

