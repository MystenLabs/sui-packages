module 0xff7a1b429024ec48c84721c477b385c3999f4a061ac11a345a143f165a7a3b37::suinaldo {
    struct SUINALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINALDO>(arg0, 6, b"SUINALDO", b"Suinaldo", b"Suiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029189_12b0828bb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINALDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

