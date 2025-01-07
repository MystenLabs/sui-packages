module 0x6e5c4f2988eac8500e2627315fadf8f479c5cee9a14f29b0d4cb1b3de976d714::ganz {
    struct GANZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANZ>(arg0, 9, b"GANZ", b"Gan-z", b"Generation zoomer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eedbe4a5-dde9-495a-ab73-384f568dc9f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

