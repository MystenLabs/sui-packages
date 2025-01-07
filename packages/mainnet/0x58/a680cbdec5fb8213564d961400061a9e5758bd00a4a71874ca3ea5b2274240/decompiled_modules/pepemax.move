module 0x58a680cbdec5fb8213564d961400061a9e5758bd00a4a71874ca3ea5b2274240::pepemax {
    struct PEPEMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEMAX>(arg0, 6, b"PEPEMAX", b"Pepetseus Maximus", x"4920616d20706570657473657573206d6178696d7573206865726520746f2074616b65206f76657220537569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v2_AR_Nfzm_H_Nayl_Rhd_Bl9k_O0n7_UI_542552a8e3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

