module 0x41b563bc78c99975dd676c14ca0b385ef5980419b7bbece223fcab11f73ab9e9::rts {
    struct RTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTS>(arg0, 6, b"RTS", b"Redtheskull", b"RedTheSkull ( $RTS ) is a memento by having animosity for the other skulls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036842_9397cf5e13.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

