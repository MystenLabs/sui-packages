module 0x6b80da5001a5b25dfcad67d0ee4cd840b40729c3b4fdb56625ec5fba9da1238c::donny {
    struct DONNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONNY>(arg0, 6, b"DONNY", b"Donny", b"sui's cutest toy DONNY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dr_6529383561.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

