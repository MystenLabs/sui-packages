module 0x55d1110b51468b5d3996a92101eb490dd24fa2935a3bb306e65936dcc20abc04::dory {
    struct DORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORY>(arg0, 6, b"DORY", b"DORYonSUI", b"KEEP SWIMMING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dory_dbc612652b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

