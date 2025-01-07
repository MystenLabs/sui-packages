module 0x87b9dae748a79e789763ae6b7e880f57186ff21c861716dfe3f240ffc46b9fba::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 6, b"SEA", b"SeaHorse AI", b"SeaHorse AI, the glowing guardian of the binary sea, combines elegance with cutting-edge innovation. Exploring the depths of decentralized intelligence, it paves the way for a new era of limitless digital possibilities and technological evolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733539019986.11")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

