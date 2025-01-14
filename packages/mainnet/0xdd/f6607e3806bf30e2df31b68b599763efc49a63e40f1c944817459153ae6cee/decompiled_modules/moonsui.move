module 0xddf6607e3806bf30e2df31b68b599763efc49a63e40f1c944817459153ae6cee::moonsui {
    struct MOONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONSUI>(arg0, 6, b"MOONSUI", b"MOON ON SUI", b"Lets go to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/972836fa_047d_414a_aa0d_fddc9f67358c_0ce82bba7a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

