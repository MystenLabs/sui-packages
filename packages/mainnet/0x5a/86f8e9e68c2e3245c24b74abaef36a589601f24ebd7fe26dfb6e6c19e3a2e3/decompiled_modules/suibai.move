module 0x5a86f8e9e68c2e3245c24b74abaef36a589601f24ebd7fe26dfb6e6c19e3a2e3::suibai {
    struct SUIBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAI>(arg0, 6, b"SUIBAI", b"Suibai", b"HABIBI COME TO SUIBAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_01_66_e332b75421.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

