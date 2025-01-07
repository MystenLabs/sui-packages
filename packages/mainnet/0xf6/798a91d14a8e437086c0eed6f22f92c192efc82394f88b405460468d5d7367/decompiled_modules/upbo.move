module 0xf6798a91d14a8e437086c0eed6f22f92c192efc82394f88b405460468d5d7367::upbo {
    struct UPBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPBO>(arg0, 9, b"UPBO", b"UPB", b"Banggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a605bec-4db0-492b-8881-f7ca432af5c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

