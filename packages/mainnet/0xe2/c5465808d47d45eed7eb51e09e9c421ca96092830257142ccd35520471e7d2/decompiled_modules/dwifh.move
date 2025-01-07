module 0xe2c5465808d47d45eed7eb51e09e9c421ca96092830257142ccd35520471e7d2::dwifh {
    struct DWIFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWIFH>(arg0, 6, b"DWIFH", b"DENG WIF HAT", b"Meet Moo Deng, the adorable baby pygmy hippo whos quickly become the internets favorite animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xee6492be7b997987e91805e182111ae6cdfd7d15278481d5dc04e093a6069f5d_dwifh_dwifh_0f02b9bfed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWIFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWIFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

