module 0xe98e404807025b422a1c7cd84abd05a2beabdc93ae43cf2d30ba70a8c0fa431b::suitzerland {
    struct SUITZERLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITZERLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITZERLAND>(arg0, 6, b"Suitzerland", b"suitzerland", x"696e766572736520737769747a65726c616e640a0a696d2062726f6b6520646576206d616b65206d7920342e3520776f72746820", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flag_of_the_greek_island_of_ikaria_v0_3rpsak9qiira1_a0482116e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITZERLAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITZERLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

