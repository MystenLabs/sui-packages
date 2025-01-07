module 0x31ab7005e08af93f57984984bd0c75fdfce61aa8332609a9de08895bb3bc3e59::eyes {
    struct EYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYES>(arg0, 6, b"EYES", b"Sui Eyes White Dragon", b"Blue Eyes White dragon come to SUI network ant transfrom into $EYES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_13_07_44_40_f79d2a5974.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYES>>(v1);
    }

    // decompiled from Move bytecode v6
}

