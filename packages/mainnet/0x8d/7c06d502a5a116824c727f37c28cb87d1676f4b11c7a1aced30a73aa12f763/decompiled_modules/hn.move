module 0x8d7c06d502a5a116824c727f37c28cb87d1676f4b11c7a1aced30a73aa12f763::hn {
    struct HN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HN>(arg0, 9, b"HN", x"48c3a0204ee1bb9969", x"48c3a0204ee1bb99692078c6b061", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b221020a-8a18-4596-ae66-df670ab4532d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HN>>(v1);
    }

    // decompiled from Move bytecode v6
}

