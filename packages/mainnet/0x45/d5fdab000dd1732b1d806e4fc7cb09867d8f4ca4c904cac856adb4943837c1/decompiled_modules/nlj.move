module 0x45d5fdab000dd1732b1d806e4fc7cb09867d8f4ca4c904cac856adb4943837c1::nlj {
    struct NLJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLJ>(arg0, 9, b"NLJ", b"NELLY07", b"A COIN FOR THE FUTURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/392342b6-f467-473a-8984-048c7e3ea850.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

