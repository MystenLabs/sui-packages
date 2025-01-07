module 0x4932f2b3961725332d61ffebe300bb4a5717c9dbca886bbd2e30a3f40dba030::besui {
    struct BESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BESUI>(arg0, 6, b"BES", b"Besui", b"Besui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

