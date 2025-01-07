module 0xd8df68b5f82d1634847cb8db766a53aaaa3e6f939cfdc52c280407e5cdf6814::groot {
    struct GROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROOT>(arg0, 6, b"GROOT", b"GROOT SUI", b"JUST GROOT GROOT GROOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/groot_bordered_f245c48272.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

