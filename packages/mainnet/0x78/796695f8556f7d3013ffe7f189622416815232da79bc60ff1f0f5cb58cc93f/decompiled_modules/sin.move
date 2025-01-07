module 0x78796695f8556f7d3013ffe7f189622416815232da79bc60ff1f0f5cb58cc93f::sin {
    struct SIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIN>(arg0, 9, b"SIN", b"SIN", b"Sorry Im Newbee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE9oqVhsUusw4S0oQuMD8HbOw2iMSC_aMVJQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

