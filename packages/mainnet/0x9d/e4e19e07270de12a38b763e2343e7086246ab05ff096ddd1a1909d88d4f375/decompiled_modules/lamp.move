module 0x9de4e19e07270de12a38b763e2343e7086246ab05ff096ddd1a1909d88d4f375::lamp {
    struct LAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMP>(arg0, 6, b"LAMP", b"LAMP.", b"ya'll got any lamps?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Web_Photo_Editor_37e2f6fd9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

