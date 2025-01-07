module 0x4471780793126b52d1e45424c8a932638be6b11bb986c6ffcb27152075e84cdd::ams {
    struct AMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMS>(arg0, 9, b"AMS", b"Amsterdamu", b"Always positive and green community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5162d552-094f-4b19-8ed8-b218a301acdf-IMG_1690.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

