module 0x39de7aebc7e9f28e262b5a8d9d06006d9467a8d9bb6109258cb4e3d04672ac48::wacky {
    struct WACKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WACKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WACKY>(arg0, 6, b"Wacky", b"WackySui", b"Serious gains, wacky vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_052936946_c3645e0e1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WACKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WACKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

