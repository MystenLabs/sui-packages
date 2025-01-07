module 0x3d1545e873c9969e9e0b0af80d648d6ad690459d772afe2a25db2a3ddcfad75::coge {
    struct COGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COGE>(arg0, 6, b"Coge", b"Cogecoin", b"Its cat season aaaaaaaaaaa,this is your last chance to make it, also before D theres C.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C0_ED_5613_0_BE_0_4_FF_8_8_E3_A_1_E7_C5661_D902_11c21e4485.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

