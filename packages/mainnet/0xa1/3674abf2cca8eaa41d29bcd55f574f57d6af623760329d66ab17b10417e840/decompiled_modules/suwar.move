module 0xa13674abf2cca8eaa41d29bcd55f574f57d6af623760329d66ab17b10417e840::suwar {
    struct SUWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWAR>(arg0, 6, b"SUWAR", b"Sui War", b"The battlefield on Sui will require heroic generals to lead the charge and inspire others with their deeds. Join the $Sui army ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zy9e_Amb_EA_Ai0k_L_abdc2b459e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

