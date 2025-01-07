module 0x3c11de5bd0e5b73e87c3fe758c40cfe77fed7ba2c30493dd96e62feb932a4136::kurwa {
    struct KURWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURWA>(arg0, 9, b"KURWA", b"Kurwa!", b"Kurwa! Kurwa!! Kurwa!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78f35d8a-2822-4129-b9a0-5bfc16c880f6-1000018895.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KURWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

