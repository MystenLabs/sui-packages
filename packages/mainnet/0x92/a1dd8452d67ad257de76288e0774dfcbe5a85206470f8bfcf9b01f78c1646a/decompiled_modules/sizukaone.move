module 0x92a1dd8452d67ad257de76288e0774dfcbe5a85206470f8bfcf9b01f78c1646a::sizukaone {
    struct SIZUKAONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZUKAONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZUKAONE>(arg0, 9, b"Sizukaone", b"Sizuka", b"Sizukaone Sizukaone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://image.civitai.com/xG1nkqKTMzGDvpLrqFT7WA/f4d0afb6-ede2-4dd4-89c3-bbc4c069e360/width=450/02410-1110395442.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIZUKAONE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZUKAONE>>(v2, @0x3e6f93f81e9cc2660e8eb52283f5c8c06c04abc6920ffa99bd849d3da0ddccee);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZUKAONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

