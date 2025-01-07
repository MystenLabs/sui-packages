module 0x13b92156506877173161cabc2ad1afb5782c96f9933d57c243e15b581109cbd8::tesdfgdffb {
    struct TESDFGDFFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESDFGDFFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESDFGDFFB>(arg0, 9, b"TESDFGDFFB", b"TESDFGDFFB", b"TESDFGDFFB f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui.directory/wp-content/uploads/2023/04/SuiNS_high_res_tw_logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESDFGDFFB>(&mut v2, 13121000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESDFGDFFB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESDFGDFFB>>(v1);
    }

    // decompiled from Move bytecode v6
}

