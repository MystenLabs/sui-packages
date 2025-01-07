module 0x3566b9ec36e77cab0f25230bd679474864a8829060f112ad39120581cc3cf031::megoinu {
    struct MEGOINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGOINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGOINU>(arg0, 6, b"MEGOINU", b"MEGOINU SUI", b"megoinu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qox_A9i_Qb_400x400_fd0d57b15c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGOINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGOINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

