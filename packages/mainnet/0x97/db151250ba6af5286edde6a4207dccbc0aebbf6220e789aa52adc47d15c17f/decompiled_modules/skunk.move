module 0x97db151250ba6af5286edde6a4207dccbc0aebbf6220e789aa52adc47d15c17f::skunk {
    struct SKUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKUNK>(arg0, 6, b"SKUNK", b"STINKY", b"Lets faaaaart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Geh7i2_M_Xs_AA_Qu_If_c87393aa73.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

