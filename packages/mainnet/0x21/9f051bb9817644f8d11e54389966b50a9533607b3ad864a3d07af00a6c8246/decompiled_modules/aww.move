module 0x219f051bb9817644f8d11e54389966b50a9533607b3ad864a3d07af00a6c8246::aww {
    struct AWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWW>(arg0, 9, b"AWW", b"arwewe", b"Yes Ser", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/894610c1-bec5-46ac-8761-c700c85661c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

