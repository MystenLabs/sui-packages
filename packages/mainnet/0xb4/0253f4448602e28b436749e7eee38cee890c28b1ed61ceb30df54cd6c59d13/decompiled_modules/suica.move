module 0xb40253f4448602e28b436749e7eee38cee890c28b1ed61ceb30df54cd6c59d13::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA>(arg0, 9, b"SUICA", b"SUICA ", b"SUICA  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmepVAVxZusWaKA7Ppc2KkCwyxDKmhcKt2iVJG3LCgfGvd"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

