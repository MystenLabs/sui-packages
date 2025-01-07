module 0xef218cf28c598638c6cb173e33cc3ae8ca998564c51e8c3ae7b646e00f371e7f::golazo {
    struct GOLAZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLAZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLAZO>(arg0, 6, b"GOLAZO", b"GOLAZOsui", b"Bridging the gap between football & web3 one meme at a time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rx9_Jg44_O_400x400_00edbd538b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLAZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLAZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

