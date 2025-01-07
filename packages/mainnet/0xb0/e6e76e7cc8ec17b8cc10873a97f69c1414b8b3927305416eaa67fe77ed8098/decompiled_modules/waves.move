module 0xb0e6e76e7cc8ec17b8cc10873a97f69c1414b8b3927305416eaa67fe77ed8098::waves {
    struct WAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVES>(arg0, 6, b"Waves", b"WaveSui", b"When you think life is a calm sea, but WaveSui swoops in and turns you into a surfer on the waves of chaos. Live with energy or hold on tight!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vv_a038ef11db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

