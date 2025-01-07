module 0x669aa3669d96a9705cdc23415818d3374f64744f023703ab67ad9e0de45f7feb::cfs {
    struct CFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFS>(arg0, 6, b"CFS", b"Catch Fish on SUI", b"Trying to Catch more Fish on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_72b32b4b88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

