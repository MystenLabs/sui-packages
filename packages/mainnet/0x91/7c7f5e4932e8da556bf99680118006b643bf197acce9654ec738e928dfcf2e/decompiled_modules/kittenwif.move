module 0x917c7f5e4932e8da556bf99680118006b643bf197acce9654ec738e928dfcf2e::kittenwif {
    struct KITTENWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTENWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTENWIF>(arg0, 6, b"KittenWif", b"KittenWifHat", b"Super-rare memecoin gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nd_Jte_Wgx_400x400_1289a5fd52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTENWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITTENWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

