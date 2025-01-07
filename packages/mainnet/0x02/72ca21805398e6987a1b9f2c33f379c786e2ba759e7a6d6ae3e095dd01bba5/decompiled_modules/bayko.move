module 0x272ca21805398e6987a1b9f2c33f379c786e2ba759e7a6d6ae3e095dd01bba5::bayko {
    struct BAYKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAYKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYKO>(arg0, 6, b"BAYKO", b"BAYKO THE NASI", b"Bayko the Nasi Monkey , he's not like the others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_8e7ad8e5b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAYKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

