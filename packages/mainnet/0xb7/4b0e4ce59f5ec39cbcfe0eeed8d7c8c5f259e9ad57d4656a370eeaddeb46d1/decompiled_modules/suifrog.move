module 0xb74b0e4ce59f5ec39cbcfe0eeed8d7c8c5f259e9ad57d4656a370eeaddeb46d1::suifrog {
    struct SUIFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFROG>(arg0, 6, b"SUIFROG", b"SUI FROG", b"Revolutionize your swapping experience with Sui Easy Defi on #SUl - the cutting-edge DeFi platform that simplifies the process  #Suinetwork #BuildOnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_02_25_09_0610790bf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

