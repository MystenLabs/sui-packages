module 0x2f06e4ea2b9af5d95cd9068298a9fddfe30b7196163fa6c753cff00ef222e08c::trumpcountry {
    struct TRUMPCOUNTRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCOUNTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCOUNTRY>(arg0, 6, b"TRUMPCOUNTRY", b"TRUMP COUNTRY", b"*OFFICIAL* DON JR TRUMP COUNTRY MEMECOIN. Telegram announcement at 20k market cap, twitter page reveal at 35k market cap, website at 50k market cap NO SOCIALS UNTIL THEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_19_194327_f6d45cff32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCOUNTRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPCOUNTRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

