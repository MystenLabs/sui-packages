module 0x6403541fcfe902e87ffb88c4308d8c6ba06455e7423fba592a7365f85fd62a70::detn {
    struct DETN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DETN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DETN>(arg0, 9, b"DETN", b"Denii Token", b"PLANET PLUTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"\"C:\\Users\\NYEIL\\OneDrive\\Pictures\\Saved Pictures\\Purple and Black Minimalist Space Desktop Wallpaper.png\"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DETN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DETN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DETN>>(v1);
    }

    // decompiled from Move bytecode v6
}

