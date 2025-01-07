module 0xf43cc003293f513614dc5c0911c8cd312be28152850be1530a12caab5893d49e::zusd {
    struct ZUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUSD>(arg0, 9, b"ZUSD", b"Zero USD", b"Zero USD The world of the future is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.icon-icons.com/icons2/3269/PNG/512/creative_commons_zero_icon_207660.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ZUSD>(&mut v2, 10000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUSD>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

