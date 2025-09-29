module 0xa8e905f1409d580f7a4a3cf4adc9cd536479d8274b50d7d2921e33cbbff5f124::hst {
    struct HST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HST>(arg0, 9, b"HST", b"Hashcase Sui Token", b"Sui coin for hashcase collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://metadata-hashcase-admin.s3.us-east-2.amazonaws.com/nft-images/1759141172267-flower-9799036_1920.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

