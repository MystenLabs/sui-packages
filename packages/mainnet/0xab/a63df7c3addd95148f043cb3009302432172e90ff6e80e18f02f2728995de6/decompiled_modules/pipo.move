module 0xaba63df7c3addd95148f043cb3009302432172e90ff6e80e18f02f2728995de6::pipo {
    struct PIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPO>(arg0, 6, b"PIPO", b"first pipo on sui", b"first pipo on sui.Join us: https://piposui.cfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20_2b899e3818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

