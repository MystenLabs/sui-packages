module 0x6e130d2e13ede3bc42fa2101d21a3d910f5bbdd0426a2ae242aed235eab8dc98::flow {
    struct FLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOW>(arg0, 6, b"FLOW", b"ORINOCO", b"Orinoco is a cutting-edge Sui blockchain token inspired by the strength and flow of the Orinoco River. Combining innovation with reliability, it symbolizes fluidity, trust, and forward-thinking technology in the cryptocurrency space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ff7dd0fc_f17a_4bda_9885_12116b79340a_6fc6330310.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

