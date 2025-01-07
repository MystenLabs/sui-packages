module 0x1a8522a2da5bdfddec6b4f1c97cb2243524ad4b607d64b6d1998c550357aba7b::wump {
    struct WUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUMP>(arg0, 6, b"WUMP", b"WumpuSui", x"57756d707573202457554d5055530a0a4d6565742052756d7075732c207468652066616d6564206d6173636f74206f6620446973636f72642e200a0a54616c656e74656420656e67696e656572207465616d2077686963682069732072656c656173696e6720616e2041726361646520616e6420537569204e465420636f6c6c656374696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_21_19_16_44_315f3e2896.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

