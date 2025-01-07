module 0x531c65352816e1ad36d5bfc3ce0fd294286ea4fda804f27e77e69f051e67403::shogun {
    struct SHOGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOGUN>(arg0, 6, b"SHOGUN", b"Shogun", b"Shogun Coin is a community-driven token designed to empower projects by providing free bots and systems that enhance engagement. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727113989750_33a377e7df34cf466c4a94f86f7fe809_8eac0d0c07.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOGUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

