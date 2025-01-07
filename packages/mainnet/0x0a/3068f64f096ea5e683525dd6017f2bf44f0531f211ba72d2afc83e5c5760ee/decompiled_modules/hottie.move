module 0xa3068f64f096ea5e683525dd6017f2bf44f0531f211ba72d2afc83e5c5760ee::hottie {
    struct HOTTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTTIE>(arg0, 6, b"HOTTIE", b"Hottie Froggie Sui", b"HOTTIE is the most interesting amphibian to ever traverse the crypto world. My legs are longer and my eyes can make even the most diamond-handed person weak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011085_3013cbb500.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOTTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

