module 0x773cc15398175b9c52003933e32ef81f8f9ba009ab4b134f78b9197b130995b9::suifood {
    struct SUIFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFOOD>(arg0, 6, b"SUIFOOD", b"SuiFood", b"Lets eat some $SUIFOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_130736_0c68e338bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

