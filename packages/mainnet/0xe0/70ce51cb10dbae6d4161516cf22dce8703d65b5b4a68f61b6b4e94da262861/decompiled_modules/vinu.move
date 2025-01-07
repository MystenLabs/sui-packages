module 0xe070ce51cb10dbae6d4161516cf22dce8703d65b5b4a68f61b6b4e94da262861::vinu {
    struct VINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINU>(arg0, 6, b"VINU", b"VITA INU", b"The only memecoin with real world utility. Zero fees, instant settlement, and high energy efficiency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_e_i_i_7b6598d03c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

