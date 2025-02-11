module 0x26e11a41d6ea980f8b96a1f936074363b601e63ef1e65e6cafb66f10e0d4aa32::harrybalz {
    struct HARRYBALZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRYBALZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRYBALZ>(arg0, 6, b"HARRYBALZ", b"Harry Balz", b"Harry Balz on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_HS_Tq_Il_D_400x400_7107b4d92a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRYBALZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRYBALZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

