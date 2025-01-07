module 0x8660993558dc2c1102384897a850388a79aeac84c6377d6466de7564f4a411f8::solv {
    struct SOLV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLV>(arg0, 6, b"SOLV", b"SOLV is SOLV Future", b"SOLV coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1638065819581300737/gM2GUNLi_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOLV>(&mut v2, 10000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLV>>(v1);
    }

    // decompiled from Move bytecode v6
}

