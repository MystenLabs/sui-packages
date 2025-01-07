module 0x12f229a0616e5fdb493b978b63d32867dddc8787741efc3096018ecea1091ef0::trumps {
    struct TRUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPS>(arg0, 6, b"TRUMPS", b"Trumpstar", x"0a245452554d50532077617320646576656c6f70656420746f206d616b65206d656d652063756c7475726520677265617420616761696e2e204e6f207574696c6974792c204f6e6c79204d656d65205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_trumps_dbedde466f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

