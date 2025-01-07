module 0x26a65dc85d665eb96317d2f03cae875acbd1e9de2b2a08f5e5e3a846e2885706::hopcry {
    struct HOPCRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCRY>(arg0, 6, b"HopCry", b"HOP CRY", b"Hop crying", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000992_0700932993.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPCRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

