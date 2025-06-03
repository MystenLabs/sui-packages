module 0x820702949f1930a6fb467fb8f34740585f2cf7efbd82692532b7e6b3f5ee1d1b::trumb {
    struct TRUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMB>(arg0, 9, b"TRUMB", b"TRUMP", x"245452554d42206973206e6f742061206c6f74206f66206d6f6e6579200a546f6b656e6973696e6720746865206d6f73742069636f6e6963206472616d6120746865207472656e6368657320686176652065766572207365656e0a546865205269736520616e642046616c6c206f66204a616d65732057796e6e3a2057696c6c204865204d616b6520497420416c6c204261636b3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d2d194b3e9e144671faebeffdf77fb53blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

