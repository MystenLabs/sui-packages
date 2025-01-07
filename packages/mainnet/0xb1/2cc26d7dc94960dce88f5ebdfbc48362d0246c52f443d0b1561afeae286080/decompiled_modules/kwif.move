module 0xb12cc26d7dc94960dce88f5ebdfbc48362d0246c52f443d0b1561afeae286080::kwif {
    struct KWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWIF>(arg0, 6, b"KWIF", b"Kitten Wif on SUI", b"Launched by the Founder of MovePump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pa921o_Sz_400x400_48ff0f484a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

