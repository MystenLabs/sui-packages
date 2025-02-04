module 0xd7e4a8ea2af98c64142342bff7dd5f503e7544d27b787b0c939319c39ff7735::asas {
    struct ASAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASAS>(arg0, 6, b"ASAS", b"asdasd", b"asdfcwedvcfwev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hero_a_NC_7o6_UU_2_428dcfeb08.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

