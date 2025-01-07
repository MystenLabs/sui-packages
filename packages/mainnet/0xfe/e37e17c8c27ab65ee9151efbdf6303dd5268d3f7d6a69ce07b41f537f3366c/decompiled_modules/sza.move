module 0xfee37e17c8c27ab65ee9151efbdf6303dd5268d3f7d6a69ce07b41f537f3366c::sza {
    struct SZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZA>(arg0, 6, b"SZA", b"SuiZilla", b"SuiZilla is a decentralized memecoin on the Sui blockchain, inspired by the iconic kaiju, Godzilla. This playful cryptocurrency aims to capture the spirit of the legendary monster and offer a fun and community-driven investment opportunity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/godzilliqa_dp_6f4edd5540.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

