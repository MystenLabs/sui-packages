module 0xdf7d30196ad4c2f36ec7bd84fe1d6a88842e51ccb12f91dfce0d3698b2b4dbb8::beegblue {
    struct BEEGBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEGBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEGBLUE>(arg0, 6, b"BeegBlue", b"Beeg Blue Whale", b"Phenomenon Whale of the #Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/beeg_15c651b0c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEGBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEGBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

