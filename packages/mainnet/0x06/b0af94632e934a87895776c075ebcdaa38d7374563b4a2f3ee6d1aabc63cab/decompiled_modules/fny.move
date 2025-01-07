module 0x6b0af94632e934a87895776c075ebcdaa38d7374563b4a2f3ee6d1aabc63cab::fny {
    struct FNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNY>(arg0, 9, b"FNY", b"Funny", b"Its okay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3d83ebd-2ebe-4c90-83ca-ef012f17543d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

