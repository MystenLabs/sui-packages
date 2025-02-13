module 0x9e1d0d4dd46ecfac3c420995336d122e3735c0a0a6a33440eab9497e830cf9ae::mlfsn {
    struct MLFSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLFSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLFSN>(arg0, 9, b"MLFSN", b"MILFASUN", b"mature and confident", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b1a5166-9b9d-44e9-ba8f-ebd5dc773c35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLFSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLFSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

