module 0x65b4ce86f2613bc23761b08412f501489530da8479a3bb7a9e0075e759e628f2::vhand {
    struct VHAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: VHAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VHAND>(arg0, 6, b"VHAND", b"Voice Hand AI by SuiAI", b"Listen, give a hand, I'm here, and you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/D_Dm_It3_O_400x400_7461f7a5f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VHAND>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VHAND>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

