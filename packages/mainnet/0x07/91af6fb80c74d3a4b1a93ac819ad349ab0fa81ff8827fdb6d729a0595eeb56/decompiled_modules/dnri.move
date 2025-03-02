module 0x791af6fb80c74d3a4b1a93ac819ad349ab0fa81ff8827fdb6d729a0595eeb56::dnri {
    struct DNRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNRI>(arg0, 6, b"DNRI", b"Denarius", b"A day's wage. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004535_97cfceb05a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

