module 0xcd35a4a33e246a98a9472f76ea2b68bed0ac742772017b811fbe33d5f313815e::bvngf {
    struct BVNGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVNGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVNGF>(arg0, 9, b"BVNGF", b"M,NB", b"XCVD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a0b5bcd-8fc7-4655-b7f9-7f504ce0750a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVNGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVNGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

