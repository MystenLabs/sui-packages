module 0x42e5438786f4d40f9e29c79baa18a10fa646a1fbc52aefbb51861376b7e2f835::pplus {
    struct PPLUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPLUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPLUS>(arg0, 6, b"PPLUS", b"Bitwise Premium+", b"This receipt token represents the shares a user has of the Bitwise Premium+ Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/PPLUS.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPLUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPLUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

