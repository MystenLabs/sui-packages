module 0x3a6968fe83f6783986df5cd01a101a26d1cea9995b08476484027bb26694875f::deadass {
    struct DEADASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEADASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEADASS>(arg0, 6, b"DeadAss", b"Deadpool's Ass", b"Pump his ass to the moon.  If this pops, website, telegram, and twitter will come after.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deadpool_2_butt_jpg_ce7acec2eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEADASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEADASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

