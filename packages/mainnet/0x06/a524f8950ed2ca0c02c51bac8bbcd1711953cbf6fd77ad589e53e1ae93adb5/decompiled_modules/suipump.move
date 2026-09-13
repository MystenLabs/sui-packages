module 0x6a524f8950ed2ca0c02c51bac8bbcd1711953cbf6fd77ad589e53e1ae93adb5::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"SUIFROG", b"SuiFrog", b"JrEast mascot living on sui, join the train!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Nczzed4.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIPUMP>>(v2);
    }

    // decompiled from Move bytecode v7
}

