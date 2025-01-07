module 0xa6745a3aad726e292e5723a8e4eedac48d3a2fd2af4dd0549c66bae2597bcb0c::gasa {
    struct GASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GASA>(arg0, 6, b"GASA", b"Token Of Gasa - Palestine", b"The token that help hundred of thousands of innocent people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_vibrant_and_stylized_logo_of_a_memecoin_pro_2_2af2d09aeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

