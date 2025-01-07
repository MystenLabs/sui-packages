module 0xb394d35ec66bdd569f07dc10f7d37ed0653ca8470c8b6165c16bb45bde03af4e::fw {
    struct FW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FW>(arg0, 6, b"FW", b"FUCKMAN", b"ffffffffuuuuuuuucccckkkkkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240925183226_bcd5f790fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FW>>(v1);
    }

    // decompiled from Move bytecode v6
}

