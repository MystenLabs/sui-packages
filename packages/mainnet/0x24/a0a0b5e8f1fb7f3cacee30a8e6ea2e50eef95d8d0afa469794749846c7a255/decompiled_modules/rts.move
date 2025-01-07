module 0x24a0a0b5e8f1fb7f3cacee30a8e6ea2e50eef95d8d0afa469794749846c7a255::rts {
    struct RTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTS>(arg0, 6, b"RTS", b"RTS ON SUI", b"RedTheSkull ( $RTS ) is a memento by having animosity for the other skulls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036841_8860c64618.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

