module 0x1f9452cfffb2abded5755900b8a0bd89565b9f6d561e7fff9087b56c966770ee::trumpwifbat {
    struct TRUMPWIFBAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWIFBAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWIFBAT>(arg0, 9, b"TrumpWifBat", b"TrumpWifBat", b"TrumpWifBat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPWIFBAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPWIFBAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWIFBAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

