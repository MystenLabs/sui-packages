module 0xdb9a2f9678dcbc754d349e5b8b935f2893e9b6d61e2939db49bfaef6beb98a0a::doli {
    struct DOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLI>(arg0, 6, b"DOLI", b"Sui Doli", b"Doli was always known for his love of salsa dancing. Every evening, he'd waddle to the park and sway to the music from a nearby cafe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_08_T002419_417_2d4a81d65a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

