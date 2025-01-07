module 0x823cdc7955895142df12ca87db0ae0bf55ed4f2869c2537c7c1c08199b1921d4::pelican {
    struct PELICAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELICAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELICAN>(arg0, 6, b"PELICAN", b"Eaten by a Pelican", b"latest X trend ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241223_033228_368_0ef97032aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELICAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELICAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

