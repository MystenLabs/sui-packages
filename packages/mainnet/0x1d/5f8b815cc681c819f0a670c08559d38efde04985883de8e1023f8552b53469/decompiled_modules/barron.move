module 0x1d5f8b815cc681c819f0a670c08559d38efde04985883de8e1023f8552b53469::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 9, b"BARRON", b"BARRON Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xc852d47fd95949d852b9a438e94bb268541b0fdff4790b78d50de1a12cca7eb5::barron::barron.png?size=lg&key=886e71"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARRON>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARRON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

