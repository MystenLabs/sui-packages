module 0x1f50a5a2cd0235bb15d6442ddfe029674546319a3df47f29cf629c74244550ea::dippysui {
    struct DIPPYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIPPYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIPPYSUI>(arg0, 6, b"DIPPYSUI", b"DIPPY ON SUI", b"DIPPY FURRIEST ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_020941882_9f52941ce8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIPPYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIPPYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

