module 0xcfebed47fb183c77254b8148b95117adb98d2440f63f7d9695d6d0c5124572ed::TRUMPET {
    struct TRUMPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPET>(arg0, 9, b"TRUMPET", b"TRUMPET", b"TRUMPET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/iMUfJ38.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPET>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPET>>(v1);
    }

    // decompiled from Move bytecode v6
}

