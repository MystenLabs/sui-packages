module 0x216c70372b35ab7a2bc4fbc952aa74894266fa761b99bf6878dc7b762bbf732d::cf {
    struct CF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CF>(arg0, 9, b"CF", b"Coffee", b"Coffee fly ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba5d2b64-e5af-47b0-9ba0-a6d242f2b1a9-IMG_1548.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CF>>(v1);
    }

    // decompiled from Move bytecode v6
}

