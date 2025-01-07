module 0xaecd68824bbeb31299c92b711d7e64ec8c291054ee0dd7e414830a8d60cbe67a::suiriken {
    struct SUIRIKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIKEN>(arg0, 6, b"SUIRIKEN", b"SUIRIKEN - SUI SHURIKEN", b"A suiriken is a specialized throwing star, inspired by the traditional Japanese shuriken. Crafted with sharp, multi-edged blades, it is designed for both precision and speed. The suiriken is compact, lightweight, and optimized for quick deployment, making", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Leonardo_Phoenix_Vibrant_2_D_illustration_of_a_solitary_blue_sh_3_677bf6343e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRIKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

