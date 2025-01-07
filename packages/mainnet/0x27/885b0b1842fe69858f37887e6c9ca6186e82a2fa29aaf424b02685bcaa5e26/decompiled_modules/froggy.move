module 0x27885b0b1842fe69858f37887e6c9ca6186e82a2fa29aaf424b02685bcaa5e26::froggy {
    struct FROGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGY>(arg0, 9, b"FROGGY", b"Froggy ", x"2246726f67677920436f696e3a2054686520726962626974696e672063727970746f63757272656e637921204469766520696e746f20446546692077697468206120746f6b656e20736f20677265656e206974206d616b6573206f74686572732063726f616b2e204576657279207472616e73616374696f6e206665656c73206c696b65206120686f7020666f7277617264e280946c65617020696e20616e64206c657420796f757220706f7274666f6c696f20737061776e206672657368206f70706f7274756e69746965732122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6000154b-c82f-414a-b124-ee408685a193.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

