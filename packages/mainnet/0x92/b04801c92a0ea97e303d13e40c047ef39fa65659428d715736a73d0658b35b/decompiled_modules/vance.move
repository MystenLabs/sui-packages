module 0x92b04801c92a0ea97e303d13e40c047ef39fa65659428d715736a73d0658b35b::vance {
    struct VANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANCE>(arg0, 6, b"VANCE", b"JD VANCE", b".D. Vance, renowned for his compelling narrative in \"Hillbilly Elegy,\" now embarks on a national stage, promising to reshape American politics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3d8a5d8a_880e_41ba_8a2e_244154f4ae84_bcdf692f72.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

