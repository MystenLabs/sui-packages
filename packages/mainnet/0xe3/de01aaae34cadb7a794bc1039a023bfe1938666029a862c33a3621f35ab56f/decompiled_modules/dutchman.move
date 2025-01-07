module 0xe3de01aaae34cadb7a794bc1039a023bfe1938666029a862c33a3621f35ab56f::dutchman {
    struct DUTCHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUTCHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUTCHMAN>(arg0, 9, b"DUTCHMAN", b"DutchmanS ", b"King of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0a604e3-4354-47d8-a3d1-907623d8cd7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUTCHMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUTCHMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

