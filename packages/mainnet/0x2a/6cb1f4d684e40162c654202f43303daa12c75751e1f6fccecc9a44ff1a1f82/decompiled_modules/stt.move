module 0x2a6cb1f4d684e40162c654202f43303daa12c75751e1f6fccecc9a44ff1a1f82::stt {
    struct STT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STT>(arg0, 9, b"STT", b"Sui TOken", b"test token sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://metadata-hashcase-admin.s3.us-east-2.amazonaws.com/nft-images/1759251136877-flower-9799036_1920.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

