module 0x14889b1ffb5ea9c775534d4300d96d8efb05eaadcb1f604ba9672d3668560b17::frc {
    struct FRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRC>(arg0, 6, b"FRC", b"KingFroc Coin", b"FRC is a new icon that will be the king in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056544_958e17c827.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

