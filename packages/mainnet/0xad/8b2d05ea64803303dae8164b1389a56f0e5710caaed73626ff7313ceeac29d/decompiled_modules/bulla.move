module 0xad8b2d05ea64803303dae8164b1389a56f0e5710caaed73626ff7313ceeac29d::bulla {
    struct BULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLA>(arg0, 6, b"BULLA", b"BullaBulla", b"Rebirth of Bulla Bulla on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bulla_Bulla_f79087dc23.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

