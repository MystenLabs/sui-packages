module 0x8a8742570aa89117a975939ade801fed0a9b91e75fc0d536b174f40114977e00::gecko {
    struct GECKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKO>(arg0, 6, b"Gecko", b"sui gecko", x"224e6f206d617474657220686f772062757379206c6966652069732c20796f752073686f756c6420656e6a6f792061206d6f6d656e74206f662072656c61786174696f6e206c696b652074686973206765636b6f2e220a0a4920686f7065207468697320706963747572652063616e206d616b6520796f75206665656c2072656c6178656420616e6420686170707921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_14_11_43_59_A_cute_tiny_gecko_swimming_in_a_small_clear_pond_The_gecko_is_floating_peacefully_its_little_legs_paddling_gently_as_it_swims_with_bubbles_rising_5786e3d0a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

