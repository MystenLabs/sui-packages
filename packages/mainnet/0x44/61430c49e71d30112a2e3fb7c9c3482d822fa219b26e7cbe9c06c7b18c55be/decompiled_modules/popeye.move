module 0x4461430c49e71d30112a2e3fb7c9c3482d822fa219b26e7cbe9c06c7b18c55be::popeye {
    struct POPEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEYE>(arg0, 6, b"Popeye", b"SailorMan", b"Popeye is an energetic man, as energetic as sui! Oh, by the way, Popeyes Chinese name is shuishou!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241009123417_a8c65dc38b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

