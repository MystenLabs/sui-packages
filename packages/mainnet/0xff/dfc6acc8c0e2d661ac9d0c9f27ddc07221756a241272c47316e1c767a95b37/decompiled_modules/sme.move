module 0xffdfc6acc8c0e2d661ac9d0c9f27ddc07221756a241272c47316e1c767a95b37::sme {
    struct SME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SME>(arg0, 9, b"SME", b"Suimeme", b"Currencies transfer among countries with the aid of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cdecffb-5406-4088-863f-316d337467ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SME>>(v1);
    }

    // decompiled from Move bytecode v6
}

