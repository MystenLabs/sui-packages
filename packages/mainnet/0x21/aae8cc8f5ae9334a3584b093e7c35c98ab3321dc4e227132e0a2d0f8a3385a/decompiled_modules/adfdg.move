module 0x21aae8cc8f5ae9334a3584b093e7c35c98ab3321dc4e227132e0a2d0f8a3385a::adfdg {
    struct ADFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADFDG>(arg0, 9, b"ADFDG", b"dfd", b"gdfgfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/313b92dc-cec7-49bb-8968-485970127c7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADFDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

