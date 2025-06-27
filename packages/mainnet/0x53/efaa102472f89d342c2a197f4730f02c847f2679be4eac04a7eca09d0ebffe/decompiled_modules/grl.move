module 0x53efaa102472f89d342c2a197f4730f02c847f2679be4eac04a7eca09d0ebffe::grl {
    struct GRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRL>(arg0, 6, b"GRL", b"girls", b"russian girls is a most beateful girls in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_D_N_D_D_D_D_ef26423a52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

