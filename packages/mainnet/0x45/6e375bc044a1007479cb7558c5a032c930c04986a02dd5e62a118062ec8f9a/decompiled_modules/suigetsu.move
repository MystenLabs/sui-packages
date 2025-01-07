module 0x456e375bc044a1007479cb7558c5a032c930c04986a02dd5e62a118062ec8f9a::suigetsu {
    struct SUIGETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGETSU>(arg0, 6, b"SUIGETSU", b"Suigetsu", b"In the depths of the Hidden Village in the Mysten Labs, where the air is thick with intrigue and danger, one name cuts through like a blade: $SUIGETSU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_4688c92e98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGETSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGETSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

