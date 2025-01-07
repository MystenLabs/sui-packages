module 0xbdc9f34f35f2f96141ef3360eb1e31e1ee50ecfc8fb2bc168d052cd2bc8c39d3::an {
    struct AN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AN>(arg0, 6, b"AN", b"an", b"ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/288635959_1177617289702575_7117542011747382689_n_08359387f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AN>>(v1);
    }

    // decompiled from Move bytecode v6
}

