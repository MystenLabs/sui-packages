module 0xa3e15c6e29dd7305090366c822ab9b2d4b1fd70f08769c29bb15b3a9a4110238::smaba {
    struct SMABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMABA>(arg0, 6, b"SMABA", b"SuiMABA", b"Make America Based Again on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0526_d00bdd380d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

