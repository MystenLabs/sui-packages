module 0x25bfc55bc4a8dbfc62a9deaea2cde237498ffde7bb811efa7faa3a44a647cf6b::takeru {
    struct TAKERU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAKERU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAKERU>(arg0, 6, b"TAKERU", b"SUI TAKERU", b"Takeru is a wolf From Japan , inspired by anime studio , will taking over the Sui Universe....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_17_09_13_8aee6eb241.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAKERU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAKERU>>(v1);
    }

    // decompiled from Move bytecode v6
}

