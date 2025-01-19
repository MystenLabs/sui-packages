module 0x642355aaed766085dc062a974f8e59f3c25c7a508a58772050218aa5d040466::boobs {
    struct BOOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBS>(arg0, 9, b"BOOBS", b"BOOBS", b"It's all about boobs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallhere.com/en/wallpaper/1348035")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOBS>(&mut v2, 5000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

