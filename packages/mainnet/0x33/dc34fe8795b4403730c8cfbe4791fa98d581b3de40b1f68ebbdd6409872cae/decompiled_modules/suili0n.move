module 0x33dc34fe8795b4403730c8cfbe4791fa98d581b3de40b1f68ebbdd6409872cae::suili0n {
    struct SUILI0N has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILI0N, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILI0N>(arg0, 6, b"SUILI0N", b"SUILION", b"After falling into the SUI, the former king of the jungle SUILION, evolved and acquired a tail to adapt to his new surroundings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_28_22_51_12_e8289c712f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILI0N>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILI0N>>(v1);
    }

    // decompiled from Move bytecode v6
}

