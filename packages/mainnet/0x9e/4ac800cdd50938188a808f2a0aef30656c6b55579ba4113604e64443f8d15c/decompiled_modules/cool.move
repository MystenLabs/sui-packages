module 0x9e4ac800cdd50938188a808f2a0aef30656c6b55579ba4113604e64443f8d15c::cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 6, b"COOL", b"Cool Pinguin", x"24434f4f4c20434f4f4c20434f4f4c0a0a4920686f706520796f75206c6561726e656420736f6d657468696e67206e657720746f6461792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/55_1755e799e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

