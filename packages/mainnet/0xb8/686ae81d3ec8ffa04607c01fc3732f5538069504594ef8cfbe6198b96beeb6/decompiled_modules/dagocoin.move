module 0xb8686ae81d3ec8ffa04607c01fc3732f5538069504594ef8cfbe6198b96beeb6::dagocoin {
    struct DAGOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGOCOIN>(arg0, 6, b"DAGOCOIN", b"DagoCOIN", b"Dagocoin is a coin that has a strong personality character, a handsome, wild and fun-loving figure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250508_234640_34021d7be3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGOCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAGOCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

