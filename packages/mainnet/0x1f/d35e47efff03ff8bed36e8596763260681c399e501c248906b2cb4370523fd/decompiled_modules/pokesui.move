module 0x1fd35e47efff03ff8bed36e8596763260681c399e501c248906b2cb4370523fd::pokesui {
    struct POKESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKESUI>(arg0, 6, b"POKESUI", b"All pokemon on SUI", b"ALL WATER POKEMON GATHER IN SUI TO BATTLE THE FAKE IMITATIONS, JOIN THEM TO SHOW WHO THE ORIGINAL WATER POKEMON ARE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/738b4867c0338fca578c977e47a6b3914a33e136_hq_cf2dbf5298.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

