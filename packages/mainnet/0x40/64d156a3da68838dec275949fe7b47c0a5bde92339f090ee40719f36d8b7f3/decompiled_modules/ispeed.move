module 0x4064d156a3da68838dec275949fe7b47c0a5bde92339f090ee40719f36d8b7f3::ispeed {
    struct ISPEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISPEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISPEED>(arg0, 9, b"ISPEED", b"IshowSpeed", b"Speed meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a105d68-8ccf-4fbe-99c5-fd93fff20eed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISPEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISPEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

