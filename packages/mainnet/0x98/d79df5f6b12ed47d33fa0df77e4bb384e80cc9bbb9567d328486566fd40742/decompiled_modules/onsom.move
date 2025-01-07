module 0x98d79df5f6b12ed47d33fa0df77e4bb384e80cc9bbb9567d328486566fd40742::onsom {
    struct ONSOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONSOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONSOM>(arg0, 6, b"ONSOM", b"ONSOMSUI", b"da keng of sui is here, ready take over the thorne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zjq_Ii4_Wg_Dk_Mjk_J_copy_1d1a034375.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONSOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONSOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

