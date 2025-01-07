module 0x1808894a6162b34774da9c621cd9ca72740d0fbff108df95763bec9c19b0d760::upsui {
    struct UPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPSUI>(arg0, 6, b"Upsui", b"only up on sui", b"The freedom starts from here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flat_illustration_of_an_upward_arrow_vector_90828651ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

