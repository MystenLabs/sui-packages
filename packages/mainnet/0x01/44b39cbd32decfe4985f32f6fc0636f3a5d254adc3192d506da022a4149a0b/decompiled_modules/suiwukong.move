module 0x144b39cbd32decfe4985f32f6fc0636f3a5d254adc3192d506da022a4149a0b::suiwukong {
    struct SUIWUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWUKONG>(arg0, 6, b"Suiwukong", b"suiwukong", b"The first Wukong meme on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f8_Vf_T8a_C_400x400_875d80f623.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

