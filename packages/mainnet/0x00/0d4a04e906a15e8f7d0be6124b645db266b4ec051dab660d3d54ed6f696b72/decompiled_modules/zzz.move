module 0xd4a04e906a15e8f7d0be6124b645db266b4ec051dab660d3d54ed6f696b72::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 9, b"ZZZ", b"Just Sleep", b"For who people like sleeping work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/539a29ab-72d0-4479-bff9-3258c5ccc6a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

