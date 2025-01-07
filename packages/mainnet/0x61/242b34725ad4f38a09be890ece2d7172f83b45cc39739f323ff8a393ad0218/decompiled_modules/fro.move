module 0x61242b34725ad4f38a09be890ece2d7172f83b45cc39739f323ff8a393ad0218::fro {
    struct FRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRO>(arg0, 6, b"FRO", b"Frope", b"Frope $Fro the frog from his humble origins tries to become a famous star in the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_06_34_18_333705dd44.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

