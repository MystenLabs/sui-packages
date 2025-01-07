module 0xb01e4009e5a276209d464431b830058e72712c95ecc017e7fb85317000941a74::bsa {
    struct BSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSA>(arg0, 6, b"BSA", b"BITCOIN SEA", b"PUMP PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pretty_Severe_Consequences_2bf77503ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

