module 0xf7578fb31e28f70cc605e1850f37a4da85e20eec4d85bad132740ca8289e3096::ak {
    struct AK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AK>(arg0, 9, b"AK", b"InvestorAK", b"The new investor gem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d45eee71-6abf-4da2-b229-24ca48f9c3c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AK>>(v1);
    }

    // decompiled from Move bytecode v6
}

