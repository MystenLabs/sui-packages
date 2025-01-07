module 0x410985755b6fde7371542b78f76142c73cb48d4b92ca662b7646c8407fdbb2f2::dogss {
    struct DOGSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSS>(arg0, 6, b"Dogss", b"Dogs Sui", b"Dogs its a memecoin on ton chain x telegram suport", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033844_d3c3922cce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

