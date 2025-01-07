module 0x390907f44420d84cd911618272409024df21d1c1bb4fe57453aa36a0583d91f1::simicat {
    struct SIMICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMICAT>(arg0, 6, b"SIMICAT", b"SUIMI CAT", b"SIMICAT IS CUTE CAT IN CHINA. Let's Pump SIMI to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_93_163ff5d27d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

