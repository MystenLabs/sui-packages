module 0x653266d0fc4d243cf312ce0056f6df11693acf658c29279eef8cc02859848333::worldlibertyfi {
    struct WORLDLIBERTYFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORLDLIBERTYFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORLDLIBERTYFI>(arg0, 6, b"Worldlibertyfi", b"worldlibertyfi", b"Introducing a new meme coin, born after Donald Trump's tweet about the launch of worldlibertyfi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wrldliberty_9852b3c2be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORLDLIBERTYFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORLDLIBERTYFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

