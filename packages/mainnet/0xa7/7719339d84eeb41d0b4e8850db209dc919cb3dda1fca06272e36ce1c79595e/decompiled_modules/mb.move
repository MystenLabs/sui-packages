module 0xa77719339d84eeb41d0b4e8850db209dc919cb3dda1fca06272e36ce1c79595e::mb {
    struct MB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MB>(arg0, 9, b"MB", b"Miband", b"Miband 10", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/025f5468-20e8-454c-97cf-8474df56586e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MB>>(v1);
    }

    // decompiled from Move bytecode v6
}

