module 0x24aaea516e0e656c1e446594b94e652e5d4d142719f0c52e3c188ee7bd392393::kid {
    struct KID has drop {
        dummy_field: bool,
    }

    fun init(arg0: KID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KID>(arg0, 9, b"KID", b"Rich Kid", b"FOR THE CULTURE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/554370d1-e605-4769-9cfe-f7e35ac074da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KID>>(v1);
    }

    // decompiled from Move bytecode v6
}

