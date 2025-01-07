module 0x15015981cdd1037bd2800b47ff36df7789a69b138db5b5a78a66a93b2e824525::rts {
    struct RTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTS>(arg0, 9, b"RTS", b"RonaldoTrumpSui", b"RonaldoTrumpSui Ready for 25-26 Bull season! RonaldoTrumpSui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Cwv_elEUoAAyKT1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RTS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

