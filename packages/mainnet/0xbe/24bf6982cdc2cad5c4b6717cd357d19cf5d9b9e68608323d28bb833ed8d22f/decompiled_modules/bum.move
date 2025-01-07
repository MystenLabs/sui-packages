module 0xbe24bf6982cdc2cad5c4b6717cd357d19cf5d9b9e68608323d28bb833ed8d22f::bum {
    struct BUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUM>(arg0, 6, b"BUM", b"WillyBumBum Coin", b"Enough about my bum, more about my coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dd_UK_CM_400x400_15c33a553e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

