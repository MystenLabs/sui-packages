module 0x8de1fcb8ee6394d0f5d33937b78841b22d3a0819ceb982ce40b162162505c51e::moa {
    struct MOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOA>(arg0, 9, b"MOA", b"Moamoa", b"Moamoa token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c34578d-8b13-40a2-bd5b-8723586d658c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

