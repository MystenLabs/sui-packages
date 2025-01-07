module 0xa32e2b37d61d69c9f8e45358a99ca5adc683f82e40aecb4c973733e9ab3c6b52::hydrated {
    struct HYDRATED has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYDRATED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYDRATED>(arg0, 6, b"Hydrated", b"Hydrated on Sui", b"Overflowing with Suis freshest drip.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hydrated_10ee7ab26d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYDRATED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYDRATED>>(v1);
    }

    // decompiled from Move bytecode v6
}

