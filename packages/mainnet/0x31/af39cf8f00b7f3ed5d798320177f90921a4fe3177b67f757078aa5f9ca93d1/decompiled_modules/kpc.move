module 0x31af39cf8f00b7f3ed5d798320177f90921a4fe3177b67f757078aa5f9ca93d1::kpc {
    struct KPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KPC>(arg0, 9, b"KPC", b"King Price", x"4b696e6720507269636520657374206c6120636f6d6d756e617574c3a9205733206465206c27656e74726570726973652064652076656e746520656e206c69676e65204b696e6720507269636520f09f91912c206c612063727970746f206e617469766520244b50432073657261206c61204d6f6e6e616965206427c3a96368616e67652064616e73206c657320667574757265206d61676173696e204b696e672050726963652e2e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/180458fd-9bfe-408c-b339-59971297cc66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

