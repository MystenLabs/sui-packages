module 0x8fd2eff55b31babdbd760a0e0354396b57ea6785768243206270d1e193c88253::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 6, b"PLOP", b"PlopSui", b"Breaking News: A high volume of water is incoming. Secure your homes as soon as possible. $PLOP is imminent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2323_2_1c7c335422.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

