module 0x60b8060a5b4fde621ee3c0eba0c4344079bd70d75c72cd6d3447dddd05f19462::piko {
    struct PIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKO>(arg0, 9, b"PIKO", b"piko", b"?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74491530-6f4e-44aa-a1ab-436a7b94d9c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

