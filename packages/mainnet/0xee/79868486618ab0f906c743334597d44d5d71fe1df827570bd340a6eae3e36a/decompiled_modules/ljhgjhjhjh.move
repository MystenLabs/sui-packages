module 0xee79868486618ab0f906c743334597d44d5d71fe1df827570bd340a6eae3e36a::ljhgjhjhjh {
    struct LJHGJHJHJH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LJHGJHJHJH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LJHGJHJHJH>(arg0, 9, b"LJHGJHJHJH", b"koioioi", b"fdfhgdfhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b865e926-5f9d-49df-bae7-077e2b167cac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LJHGJHJHJH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LJHGJHJHJH>>(v1);
    }

    // decompiled from Move bytecode v6
}

