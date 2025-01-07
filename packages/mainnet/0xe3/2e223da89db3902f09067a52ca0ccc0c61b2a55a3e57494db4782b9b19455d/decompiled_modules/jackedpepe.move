module 0xe32e223da89db3902f09067a52ca0ccc0c61b2a55a3e57494db4782b9b19455d::jackedpepe {
    struct JACKEDPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKEDPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKEDPEPE>(arg0, 6, b"JACKEDPEPE", b"JackedPepe", b"All about the pumps. Muscle, market, and memes. JackedPepe is pumping to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_28_13_05_57_A_digital_illustration_of_Pepe_the_Frog_entirely_blue_including_his_face_with_a_muscular_and_pumped_up_body_showing_extreme_confusion_His_face_is_2efed996cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKEDPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKEDPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

