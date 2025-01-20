module 0xa204f13079c4f178f6913bd0923ede82e4ffb0ac3cab411e90bd401c0851f424::cmt {
    struct CMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMT>(arg0, 9, b"CMT", b"CheckMate", b"Lineage2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58bcfa06-5b6d-4939-bda0-cd8151883f39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

