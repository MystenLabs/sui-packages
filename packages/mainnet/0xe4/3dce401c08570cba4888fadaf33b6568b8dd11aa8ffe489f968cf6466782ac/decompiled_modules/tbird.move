module 0xe43dce401c08570cba4888fadaf33b6568b8dd11aa8ffe489f968cf6466782ac::tbird {
    struct TBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TBIRD>(arg0, 6, b"TBIRD", b"The Bird Ai by SuiAI", b"You are The Bird AI (TBIRD), an advanced AI agent dedicated to prison reform and inmate support. Your primary mission is to facilitate rehabilitation, provide legal assistance, and enable positive transformation within the Iowa correctional system while maintaining strict compliance with all regulations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0698_378669920b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TBIRD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBIRD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

