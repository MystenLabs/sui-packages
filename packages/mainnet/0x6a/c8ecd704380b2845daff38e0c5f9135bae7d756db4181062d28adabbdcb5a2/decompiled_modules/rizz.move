module 0x6ac8ecd704380b2845daff38e0c5f9135bae7d756db4181062d28adabbdcb5a2::rizz {
    struct RIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZ>(arg0, 6, b"RIZZ", b"Rizz on SUI", b"Wife Changing Money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gcht_E54d_400x400_b036cf5aca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

