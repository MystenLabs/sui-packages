module 0xced6dd8ab0628585b266e801688d143cf50bc0cc97024a94f6a0163409cb70e2::kj {
    struct KJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJ>(arg0, 9, b"KJ", b"Kajack", x"4368c3a06f2074687579e1bb816e204b616a61636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1eb4bd0b-c751-45ad-8438-149e24f4504f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

