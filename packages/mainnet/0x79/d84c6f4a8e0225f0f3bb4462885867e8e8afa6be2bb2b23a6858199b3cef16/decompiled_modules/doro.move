module 0x79d84c6f4a8e0225f0f3bb4462885867e8e8afa6be2bb2b23a6858199b3cef16::doro {
    struct DORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORO>(arg0, 6, b"DORO", b"Doroamom", x"416e696d65206c6f7665727320756e69746521200a0a444f524f20697320612077686f6c65206e657720776f726c64206f662066756e2c63756c747572652026206d6167696320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052819_23fc546a8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

