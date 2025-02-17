module 0xef15bfa3e422451a798b45e1dd25b3209617352b2602c92789673464b4b33b24::memdex {
    struct MEMDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMDEX>(arg0, 6, b"MEMDEX", b"MEMDEX1000", b"Memdex100 is the backbone of the global financial ecosystem. Using quantum powered Al oracles to make profit for the entire degen universe. NEW since old hacked", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ek_Vt4bg5s_V_Ho0_BAP_c63e7af2ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMDEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMDEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

