module 0xc27d83161af14df55274ae673a381c19eaf1847232bc50180ab1f7ab6fa6bbcf::nilofi {
    struct NILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NILOFI>(arg0, 6, b"NiLofi", b"Niga Lofi", b"The Official Niga Lofi On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/niga_lofi_portal_71d64edcbc.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NILOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NILOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

