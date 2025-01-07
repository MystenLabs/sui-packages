module 0x72e709466ab961c39e945ed612e6d780cfc0fca8714e9733810f2116ff3ad89e::fed {
    struct FED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FED>(arg0, 9, b"FED", b"Fedy", b"Ferrari", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26e8fa6f-b06d-48d3-85c5-87ff719c4578.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FED>>(v1);
    }

    // decompiled from Move bytecode v6
}

