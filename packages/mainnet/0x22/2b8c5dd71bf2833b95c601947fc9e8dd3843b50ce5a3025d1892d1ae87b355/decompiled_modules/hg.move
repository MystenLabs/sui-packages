module 0x222b8c5dd71bf2833b95c601947fc9e8dd3843b50ce5a3025d1892d1ae87b355::hg {
    struct HG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HG>(arg0, 9, b"HG", x"c6af45", b"BCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f6a1009-7cf8-4e42-a31a-c86bb4f521d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HG>>(v1);
    }

    // decompiled from Move bytecode v6
}

