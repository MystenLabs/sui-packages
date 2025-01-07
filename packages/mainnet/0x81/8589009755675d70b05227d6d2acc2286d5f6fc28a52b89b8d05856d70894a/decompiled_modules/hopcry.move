module 0x818589009755675d70b05227d6d2acc2286d5f6fc28a52b89b8d05856d70894a::hopcry {
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

