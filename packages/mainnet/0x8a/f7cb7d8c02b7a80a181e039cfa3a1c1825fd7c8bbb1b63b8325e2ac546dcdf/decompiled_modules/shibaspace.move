module 0x8af7cb7d8c02b7a80a181e039cfa3a1c1825fd7c8bbb1b63b8325e2ac546dcdf::shibaspace {
    struct SHIBASPACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBASPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBASPACE>(arg0, 6, b"SHIBASPACE", b"SPACEDSHIBA", b"SHIBA ON HIS QUEST BACK TO SPACE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ASTEROID_TTQ_9kk_ZDA_Sh_Bp0_Xb0y_dc14f96342.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBASPACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBASPACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

