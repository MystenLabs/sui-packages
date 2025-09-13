module 0xfcbb81463cf2e6f3bd6ed7a3a99d727c675bf9710b54246ced4000cad7e600c2::vitalik {
    struct VITALIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VITALIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VITALIK>(arg0, 9, b"VITALIK", b"Vitalik on SUI", b"Dance to the moon | Website: https://x.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/13ZkgsI.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VITALIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VITALIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

