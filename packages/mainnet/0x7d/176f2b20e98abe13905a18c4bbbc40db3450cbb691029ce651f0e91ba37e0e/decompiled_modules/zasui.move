module 0x7d176f2b20e98abe13905a18c4bbbc40db3450cbb691029ce651f0e91ba37e0e::zasui {
    struct ZASUI has drop {
        dummy_field: bool,
    }

    public fun add_addr_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<ZASUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<ZASUI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ZASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ZASUI>(arg0, 6, b"ZAS", b"Zasui", b"Zasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZASUI>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ZASUI>>(v1, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZASUI>>(v2);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<ZASUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<ZASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

