module 0xfea6be87e721fc44665822082a7211bded66f4c41405c924e84f3e9d197d18c9::suiwoof {
    struct SUIWOOF has drop {
        dummy_field: bool,
    }

    public entry fun update_description<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String) {
        0x2::coin::update_description<T0>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<T0>(arg0, arg1, arg2);
    }

    public entry fun update_symbol<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<T0>(arg0, arg1, arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIWOOF>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIWOOF>>(arg0, arg1);
    }

    fun init(arg0: SUIWOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOOF>(arg0, 9, b"SUIWOOF", b"SUIWOOF", b"SUIWOOF  is a deflationary token that will be utilized by SUI ecosystem applications. The total supply of SUIWOOF tokens is 210,000,000,000,000,000. SUIWOOF is owned by everyone in the SUI community and serves as a crucial key to unlock the future utilities of the SUIWOOF universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gcs/files/6c2ce33eefa4a583cb08283cfdd004ff.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIWOOF>(&mut v2, 18000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOOF>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

