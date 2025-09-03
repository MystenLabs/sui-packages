module 0x69c3e783672f7623c4d834d98c1107bba3adac290bb77bd12f28d3b022657764::Tyson {
    struct TYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYSON>(arg0, 9, b"TYSON", b"Tyson", b"punch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gzz-jJ9WMAAkSFi?format=jpg&name=900x900")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

