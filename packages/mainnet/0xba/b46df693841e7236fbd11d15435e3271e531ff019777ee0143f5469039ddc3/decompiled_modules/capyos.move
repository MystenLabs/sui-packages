module 0xbab46df693841e7236fbd11d15435e3271e531ff019777ee0143f5469039ddc3::capyos {
    struct CAPYOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYOS>(arg0, 9, b"CapyOS", b"CapyOS", b"FIRST MEME and MASCOT on SuiOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/BEsFAwH.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAPYOS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

