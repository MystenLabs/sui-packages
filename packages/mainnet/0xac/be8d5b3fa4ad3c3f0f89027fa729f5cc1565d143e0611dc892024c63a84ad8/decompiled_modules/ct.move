module 0xacbe8d5b3fa4ad3c3f0f89027fa729f5cc1565d143e0611dc892024c63a84ad8::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT>(arg0, 9, b"CT", b"CatHunt", b"Cat hunt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e051e0a0-e7bb-4115-9398-c428d8909691.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CT>>(v1);
    }

    // decompiled from Move bytecode v6
}

