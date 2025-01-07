module 0xeccadb1dc95b50b406e4f7c11d728b03fe5de2df999105387cfc2f856e60df5e::hoot {
    struct HOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOT>(arg0, 6, b"HOOT", b"HOOTLIFE", b"Whatchu know bout dat HOOTLIFE on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GJ_3k_Kr_Z_Wc_AME_Pj_W_3c10e30fca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

