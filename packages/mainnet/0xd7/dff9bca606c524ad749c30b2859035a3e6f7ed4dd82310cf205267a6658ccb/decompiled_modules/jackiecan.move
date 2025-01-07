module 0xd7dff9bca606c524ad749c30b2859035a3e6f7ed4dd82310cf205267a6658ccb::jackiecan {
    struct JACKIECAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKIECAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKIECAN>(arg0, 9, b"JACKIECAN", b"Jakie", b"Artis Hollywood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a01c816-a0c3-4d9c-9bd2-feed73eda74d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKIECAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JACKIECAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

