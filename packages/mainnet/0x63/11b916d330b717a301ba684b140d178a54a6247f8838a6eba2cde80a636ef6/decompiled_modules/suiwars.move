module 0x6311b916d330b717a301ba684b140d178a54a6247f8838a6eba2cde80a636ef6::suiwars {
    struct SUIWARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARS>(arg0, 6, b"SUIWARS", b"SUI STAR WARS", b"May The Pump Be With You!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwarsprof_2515121b37.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

