module 0xf2b611d19151548ecb26e31dd41db284e35769471c653823958c49af58b45d32::erngcity {
    struct ERNGCITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERNGCITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERNGCITY>(arg0, 9, b"ERNGCITY", b"MZK", x"5468697320697320746865206f6666696369616c20746f6b656e2066726f6d204561726e696e6773204369747920f09f8f99efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/379e901c-997b-4a76-881c-6a579ce62c4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERNGCITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERNGCITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

