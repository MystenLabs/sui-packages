module 0xb0e180f7763da95d92357764386966a2618017e18a70036bc49c6ecc3a365ae4::wetcat {
    struct WETCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETCAT>(arg0, 6, b"WETCAT", b"Wet Cat", b"The cat got wet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030663_a55c88ec1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

