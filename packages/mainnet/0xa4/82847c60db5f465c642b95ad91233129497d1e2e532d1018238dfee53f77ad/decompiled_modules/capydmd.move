module 0xa482847c60db5f465c642b95ad91233129497d1e2e532d1018238dfee53f77ad::capydmd {
    struct CAPYDMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYDMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYDMD>(arg0, 6, b"CAPYDMD", b"Capy Diamond", b"Diamond hands capybara is the true king of coolnes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028625_1af6496559.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYDMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYDMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

