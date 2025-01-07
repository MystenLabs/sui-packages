module 0xd79af6ebfe14dd2254a99b1b73e0bad1e15ce2230b49643128d62ccf202bcbd::djfmcn {
    struct DJFMCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJFMCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJFMCN>(arg0, 9, b"DJFMCN", b"Ysjansn", b"Djdndn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ba35209-b24c-483e-9ee1-fe780fc77225.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJFMCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJFMCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

