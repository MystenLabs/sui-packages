module 0xefa5792fe65dabe2122cb5eae87e06ec5f339aa09e145f59c35ecd5823adcf7c::suichi {
    struct SUICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHI>(arg0, 6, b"SUICHI", b"Suichi Pokemon", b"Suichi will grant wishes for diamond hands on SuiNetwork, no roadmap, no promises, hold $SUICHI and your wishes will come true.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigumyzu25jccjvkda54hpwfchtzxdcpzfmchhibbvorqfhmrn6miy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

