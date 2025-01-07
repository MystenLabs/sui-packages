module 0xd58db75d588fcc4c5d5828f2412a9cbde76be40e4b049ce390b472c78e8ff9da::bcs {
    struct BCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCS>(arg0, 6, b"BCS", b"Bitcat on SUI", b"Fastest cat on chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R2h_EVSP_9_400x400_5a30d57b84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

