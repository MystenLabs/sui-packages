module 0x47c8ff8030ef87bc2788439a19b8a30446ce6f47a3344cb95cafb1e615276653::reddog {
    struct REDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDDOG>(arg0, 9, b"REDDOG", b"Red", x"4de1bb9974206368c3ba206368c3b32073e1bba32074e1baaf6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8adbe7fe-7d06-4fe9-a98c-b710e541d35d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

