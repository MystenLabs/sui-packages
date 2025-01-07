module 0x5c718ab41437adb929fc65ce00fd02724179c88691b49cdec4b3ba587035c8e2::hanabi {
    struct HANABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANABI>(arg0, 9, b"HANABI", b"Hanabi Inu", b"$HANABI - Part of the Kabosumama Circle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x67e610a7b7e7ab766e06301c676f84590e5256a7.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HANABI>(&mut v2, 666000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANABI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

