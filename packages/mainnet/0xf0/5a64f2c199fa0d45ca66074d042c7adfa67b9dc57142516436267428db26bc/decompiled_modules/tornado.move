module 0xf05a64f2c199fa0d45ca66074d042c7adfa67b9dc57142516436267428db26bc::tornado {
    struct TORNADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORNADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORNADO>(arg0, 6, b"Tornado", b"Florida Tornado", b"After Hurricane Milton in Florida, at least 16 deaths and 50 billion damages", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/08_CLI_tornado_clusters_flqw_medium_Square_At3_X_c34d82bd03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORNADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORNADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

