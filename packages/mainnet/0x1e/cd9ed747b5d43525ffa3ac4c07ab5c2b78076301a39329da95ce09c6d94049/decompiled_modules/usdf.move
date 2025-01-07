module 0x1ecd9ed747b5d43525ffa3ac4c07ab5c2b78076301a39329da95ce09c6d94049::usdf {
    struct USDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDF>(arg0, 6, b"USDF", b"Uno Sui Dollar Fun", b"The first original decentralized(CTO) (un)stable memecoin on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730977373210.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

