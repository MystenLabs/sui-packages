module 0x10258ae1c1dbf7c54b247afe4c7267979516cf94e239293d806ec6abf9a8caf1::osas {
    struct OSAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAS>(arg0, 6, b"OSAS", b"OSAS on SUI", b"Ovuvuevuevue Enyetuenwuevue Ugbemugbem Osas, ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qkq9_Y_Di_E_400x400_73f9d03c18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

