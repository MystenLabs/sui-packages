module 0xcccbcc4f89f69d93d2ba8b267590ca45bc27062db12b04aa7ad034fe39318bd6::prts {
    struct PRTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRTS>(arg0, 6, b"PRTS", b"PIRATES", b"First Pirates Token On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pir_8d90d57e35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

