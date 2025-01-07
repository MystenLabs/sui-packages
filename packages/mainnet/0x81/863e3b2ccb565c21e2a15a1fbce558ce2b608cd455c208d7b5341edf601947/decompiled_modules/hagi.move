module 0x81863e3b2ccb565c21e2a15a1fbce558ce2b608cd455c208d7b5341edf601947::hagi {
    struct HAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGI>(arg0, 6, b"HAGI", b"HAGI ", b"Gheorghe Hagi, the best Romanian football player who is also known for his funny speeches, as he calls them \"mototo\" and which have become real memes over time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730828050394.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

