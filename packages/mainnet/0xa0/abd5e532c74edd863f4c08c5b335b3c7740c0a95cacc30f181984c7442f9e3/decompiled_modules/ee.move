module 0xa0abd5e532c74edd863f4c08c5b335b3c7740c0a95cacc30f181984c7442f9e3::ee {
    struct EE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EE>(arg0, 9, b"EE", b"Error ", b"Just a reminder that you can ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d016111-8bf1-4832-919f-8a1118067c80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EE>>(v1);
    }

    // decompiled from Move bytecode v6
}

