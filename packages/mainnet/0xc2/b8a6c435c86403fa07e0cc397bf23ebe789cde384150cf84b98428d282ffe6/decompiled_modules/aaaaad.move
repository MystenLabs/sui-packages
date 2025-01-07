module 0xc2b8a6c435c86403fa07e0cc397bf23ebe789cde384150cf84b98428d282ffe6::aaaaad {
    struct AAAAAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAD>(arg0, 6, b"AAAAAD", b"aaaaa", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zdzl_Wf_XUAAMZ_Vm_b730b90fac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

