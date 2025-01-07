module 0x642fec1cb9fb7db39f2d5f7bf30f47d241b7f98746e8597b782c3d988b262b45::yamahb {
    struct YAMAHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAMAHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAMAHB>(arg0, 9, b"YAMAHA", b"YaMaHa", b"The coin for Luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAMAHB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAMAHB>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<YAMAHB>>(0x2::coin::mint<YAMAHB>(&mut v2, 4000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

