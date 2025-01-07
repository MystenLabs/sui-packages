module 0x2e25698ee94ce678c6194bb550c7b8472b92a543831a98b300402761a511ca32::daoto {
    struct DAOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOTO>(arg0, 9, b"DAOTO", b"Bedao", b"Nu34", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8920badc-a019-4469-8ccf-a83ae163de50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

