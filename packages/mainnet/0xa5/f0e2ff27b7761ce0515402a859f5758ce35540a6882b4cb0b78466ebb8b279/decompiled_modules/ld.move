module 0xa5f0e2ff27b7761ce0515402a859f5758ce35540a6882b4cb0b78466ebb8b279::ld {
    struct LD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LD>(arg0, 9, b"LD", b"Lost dogs", x"4368c3ba206368c3b320c49169206ce1baa163", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14442f13-5de0-4dc2-9e1a-abbb7396f727.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LD>>(v1);
    }

    // decompiled from Move bytecode v6
}

