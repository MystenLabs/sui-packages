module 0x5b35430d263fb5b9ac34b803bbb4886dcb9a1108c915a72d92cd4dd9f89cc125::pooter {
    struct POOTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOTER>(arg0, 9, b"Pooter", b"POOTER", b"Suilend? Nah, Suirobbery. | Website: https://x.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/KfZISix.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

