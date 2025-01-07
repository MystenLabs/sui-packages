module 0x4baa7277b9dca25941a26fbc034c2a7ac95ad21bb82a9b34da10a5cec4e9a6a7::ee13145210 {
    struct EE13145210 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EE13145210, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EE13145210>(arg0, 9, b"EE13145210", b"qqq", b"Handsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d4dcff8-36c4-45c6-b709-a08b4e5a4eef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EE13145210>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EE13145210>>(v1);
    }

    // decompiled from Move bytecode v6
}

