module 0x8f21931b069f1b231b79ee7b302dc2c437be0b1379593aaac98de382951f506c::avnt {
    struct AVNT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AVNT>, arg1: 0x2::coin::Coin<AVNT>) {
        0x2::coin::burn<AVNT>(arg0, arg1);
    }

    fun init(arg0: AVNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVNT>(arg0, 9, b" AVNT ", b" AVNT ", b"This is AVNT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public.bnbstatic.com/image-proxy/rs_lg_webp/static/academy/uploads-original/685b601bf6ad45da9503f532f1e3a586.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AVNT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AVNT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AVNT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

