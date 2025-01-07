module 0xef465f2c8ebbde779d83505bac0e8525555e1ea8187266909df77bae3a7815d3::barkchain {
    struct BARKCHAIN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 8, b"BARKCHAIN", b"BARK", b"BARKCHAIN is a playful cryptocurrency inspired by the loyalty and energy of dogs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/barkchain-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: BARKCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<BARKCHAIN>(arg0, arg1);
        0x2::coin::mint_and_transfer<BARKCHAIN>(&mut v0, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BARKCHAIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

