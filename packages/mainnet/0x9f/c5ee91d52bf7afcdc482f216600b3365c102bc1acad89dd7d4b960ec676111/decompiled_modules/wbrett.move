module 0x9fc5ee91d52bf7afcdc482f216600b3365c102bc1acad89dd7d4b960ec676111::wbrett {
    struct WBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBRETT>(arg0, 6, b"WBRETT", b"WBrett on SUI", x"46697273742077726170706564204272657474206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Caj_G7vkl_400x400_45ac1f9c99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

