module 0x7e644fa85f5999c21a1c58176aec5c3433d15971e337fc385438b7708566f640::suiped {
    struct SUIPED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPED>(arg0, 6, b"Suiped", b"SUI APED", x"53554920415045442061206d656d6520746f6b656e20696e20746865205375692065636f73797374656d2e0a537569204170656420697320636f6d6d756e6974792064726976656e20616e642063616e6e6f7420626520636f6e74726f6c6c656420627920616e796f6e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_14_13_57_696f3b528f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPED>>(v1);
    }

    // decompiled from Move bytecode v6
}

