module 0xb94ee014d00cf733fd54d63cbfde629b32f94032cffff158458c73d0940d8e46::DADDYCOOL {
    struct DADDYCOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDYCOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDYCOOL>(arg0, 6, b"DADDYCOOL", b"DADDYCOOL", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ClNfMPT.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DADDYCOOL>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDYCOOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDYCOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

