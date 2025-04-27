module 0xd608255420e078a5583279a9852f4580e09db69fa2e4ef845e919df21386f305::ooo {
    struct OOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOO>(arg0, 9, b"OOOQ", b"ooo", b"w", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OOO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

