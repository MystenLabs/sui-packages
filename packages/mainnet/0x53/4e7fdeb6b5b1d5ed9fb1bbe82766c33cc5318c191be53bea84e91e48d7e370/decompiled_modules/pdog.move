module 0x534e7fdeb6b5b1d5ed9fb1bbe82766c33cc5318c191be53bea84e91e48d7e370::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"PDOG", b"Pyramid Dog", x"476f696e6720566972616c202220446f672073706f747465642068616e67696e67206f7574206f6e20746f70206f6620616e6369656e7420707972616d696420696e20456779707422776861740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_21_at_22_24_59_e5c13477_17519d57a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

