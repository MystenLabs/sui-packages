module 0x458a0dc3746122f61c6279bb1f879e74f7954647ca156b7667364d2627aa7cf0::s8_ {
    struct S8_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: S8_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S8_>(arg0, 9, b"S8_", b"masi", b"help to be rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66a656f3-1014-49f2-b342-6eb8c40c7813.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S8_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S8_>>(v1);
    }

    // decompiled from Move bytecode v6
}

