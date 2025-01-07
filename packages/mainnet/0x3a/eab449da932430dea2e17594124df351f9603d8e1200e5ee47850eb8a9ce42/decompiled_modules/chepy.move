module 0x3aeab449da932430dea2e17594124df351f9603d8e1200e5ee47850eb8a9ce42::chepy {
    struct CHEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPY>(arg0, 6, b"CHEPY", b"Chepy On Sui", b"Chepy here, famous AF if you haven't heard of me , you're living in the wrong universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002043_db5f29d1a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

