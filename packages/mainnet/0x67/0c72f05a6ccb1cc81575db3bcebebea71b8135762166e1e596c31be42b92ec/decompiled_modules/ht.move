module 0x670c72f05a6ccb1cc81575db3bcebebea71b8135762166e1e596c31be42b92ec::ht {
    struct HT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HT>(arg0, 9, b"HT", b"Hongthat", b"Hongthatcong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a47d7b9f-7fbf-4f74-ad28-4e5f08d89872.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HT>>(v1);
    }

    // decompiled from Move bytecode v6
}

