module 0xe0070383eb823bf37471a3bf34c0e343df548669b4140eec049ad2624c8e9819::suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREN>(arg0, 6, b"SUIREN", b"Sui Siren", b"Sui Siren ($SIREN) is calling from the deep waters of the Sui Network. Luring in the brave and bold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_8_c5894ccbd0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

