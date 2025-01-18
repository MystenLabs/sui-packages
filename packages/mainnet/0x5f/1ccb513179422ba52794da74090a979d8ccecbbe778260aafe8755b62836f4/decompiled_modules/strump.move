module 0x5f1ccb513179422ba52794da74090a979d8ccecbbe778260aafe8755b62836f4::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 9, b"STRUMP", b"Sui Trump", b"The crypto president on the Sui Network. Blue is Better. Make Sui Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x0b5413f35dfa207306c24763146fd4891c243960.png?size=lg&key=8876fb")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STRUMP>>(0x2::coin::mint<STRUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STRUMP>>(v2);
    }

    // decompiled from Move bytecode v6
}

