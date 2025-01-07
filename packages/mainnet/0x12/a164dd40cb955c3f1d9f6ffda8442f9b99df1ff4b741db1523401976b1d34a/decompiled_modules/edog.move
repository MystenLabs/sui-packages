module 0x12a164dd40cb955c3f1d9f6ffda8442f9b99df1ff4b741db1523401976b1d34a::edog {
    struct EDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOG>(arg0, 6, b"EDOG", b"ELECTRICAL DOGE", x"526561647920746f204c4f4c3f204d656574200a4045444f475375690a2074686520646f672077686f207468696e6b73206865277320612070726f2067616d657220627574206b6565707320726167652d7175697474696e6720276361757365207061777320646f6e742068617665207468756d6273202054686973206d656d652d6675656c656420646567656e20697320616c6c2061626f75742073656e64696e67206974206f6e20537569436861696e0a2c2064726f7070696e67202357656233206d61676963206c696b652069742773206120736c6f62626572792074656e6e69732062616c6c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3895_f46ebcda58.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

