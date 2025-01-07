module 0x1ca019117a810ede57ec72e80e405045b37a629945695b2f27ca4d57ef1644f6::sharkira {
    struct SHARKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKIRA>(arg0, 6, b"SHARKIRA", b"SharkIRA", b"With every tail movement, $SHARKIRA lets out a Hips Dont Lie, swimming with the vibrant energy of La Tortura and the cunning of She Wolf.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_22_26_43_1f7b501081.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

