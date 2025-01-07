module 0x8e33aa26127f0ca21d04e2bd242028f703c93b34da2e9e034252c6e5f651fde5::mns {
    struct MNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNS>(arg0, 9, b"MNS", b"Mansur", b"Mnstoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb54a388-edc3-42f9-bd3d-b3a70f67edd1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

