module 0x3a0584c8e1ae64fa4e591dcaef81a26eda40636b072fc78accb7c35644cf00bc::SUILION {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 2, b"SUILION", b"Suilion", b"Making SUI the best for millions, https://x.com/suiliononsui, https://suilion.io/, https://t.me/suiliononsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/PJ2YX0Nw/HWAAu-XA2-400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILION>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILION>(&mut v2, 10000000000000, @0xac2f2aa1d8723975282a98bffa73b8aa39ac03bb94a547c3b1f8368093d48d04, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

