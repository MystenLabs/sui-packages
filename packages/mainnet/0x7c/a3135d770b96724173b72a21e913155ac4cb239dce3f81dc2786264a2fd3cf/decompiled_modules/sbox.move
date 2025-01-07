module 0x7ca3135d770b96724173b72a21e913155ac4cb239dce3f81dc2786264a2fd3cf::sbox {
    struct SBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOX>(arg0, 9, b"SBOX", b"Suiboxer", b"Suiboxer is a community-driven token built on the Sui Network, a decentralized platform that aims to empower individuals and foster a sense of community within the cryptocurrency ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c81a43d-289f-4b6b-bba2-10ee157b5531.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

