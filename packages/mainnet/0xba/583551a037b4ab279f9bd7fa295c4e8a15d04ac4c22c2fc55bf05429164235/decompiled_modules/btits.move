module 0xba583551a037b4ab279f9bd7fa295c4e8a15d04ac4c22c2fc55bf05429164235::btits {
    struct BTITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTITS>(arg0, 6, b"BTITS", b"BlueTits", b"Blue Tits is awesome! We lobve Blue Tits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Schermafbeelding_2024_09_17_om_14_11_37_e3d339a996.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

