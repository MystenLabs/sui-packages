module 0xc4a4de3de4296b42cc8ba18a9e851766680e1bd1e95fd7d10718446d19fd8487::bulla {
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

