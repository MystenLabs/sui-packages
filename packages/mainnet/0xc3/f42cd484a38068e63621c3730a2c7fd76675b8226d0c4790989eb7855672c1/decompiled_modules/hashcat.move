module 0xc3f42cd484a38068e63621c3730a2c7fd76675b8226d0c4790989eb7855672c1::hashcat {
    struct HASHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASHCAT>(arg0, 6, b"HASHCAT", b"HashCatSui", x"54686520244841534843415420737469636b65722073756464656e6c79206170706561726564206f6e2054656c656772616d20616e6420717569636b6c7920626563616d6520612073656e736174696f6e2e20576974682069747320637574650a696d6167657320616e642066756e6e792065787072657373696f6e732c207468697320737469636b657220626563616d6520746865206e657720227472656e642220696e20636f6e766572736174696f6e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_11_5a62422c56.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

