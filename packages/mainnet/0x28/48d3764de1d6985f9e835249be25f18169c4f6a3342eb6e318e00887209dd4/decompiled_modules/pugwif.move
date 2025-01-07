module 0x2848d3764de1d6985f9e835249be25f18169c4f6a3342eb6e318e00887209dd4::pugwif {
    struct PUGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWIF>(arg0, 6, b"PUGWIF", b"PugwifhatPugwifhat", b"Resurging from the ashes of a premature rug, arose the pug that doesn't quit. His message is clear: he won't stand for scams", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pugwif_252e108e12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

