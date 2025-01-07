module 0xcb81539ede5604771056792893c9f19eb34cbd80d54e944956cdda09d62b8075::suino1 {
    struct SUINO1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINO1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINO1>(arg0, 6, b"SuiNo1", b"Agent No1", b"[SU1NO1] is the first community-driven AI agent on $SUI, be part of the revolution and shape the future of decentralized intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012428_f5fff407e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINO1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINO1>>(v1);
    }

    // decompiled from Move bytecode v6
}

