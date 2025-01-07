module 0x4f25c48024713e7f10ca807f5f211aec8bf530b17a48ffc254d92dbb6007ec78::hellomfcke {
    struct HELLOMFCKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLOMFCKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLOMFCKE>(arg0, 9, b"HELLOMFCKE", b"HelloMFCk", b"Hellooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52e93468-8f34-4147-8612-d52abb4b74ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLOMFCKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLOMFCKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

