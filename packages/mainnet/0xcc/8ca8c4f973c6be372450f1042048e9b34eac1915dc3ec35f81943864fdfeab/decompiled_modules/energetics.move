module 0xcc8ca8c4f973c6be372450f1042048e9b34eac1915dc3ec35f81943864fdfeab::energetics {
    struct ENERGETICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENERGETICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENERGETICS>(arg0, 9, b"ENERGETICS", b"Energetics", b"Absolutely zero chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/14051500/file/original-70a75ae0c9f5b0d2a7d91f1b28cdbc74.png?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ENERGETICS>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENERGETICS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENERGETICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

