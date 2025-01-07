module 0x8690c07f363ef9efe908f4013f5d7d9c34ba14d68ff7eb7700e2b42d48ef16e9::npc {
    struct NPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPC>(arg0, 6, b"NPC", b"non-player character", x"244e50432069732074727565206d656d652d6261636b6564206d6f6e657920666f722065766572792068756d616e206f6e2045617274682e0a446f63756d656e74696e67204e5043732061726f756e642074686520776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D2oj_To5_Ss_Wpt_Eq2_G4ig_Hy_Up_E_Mm_U_Xh_AAPV_Ak61e_E_Zbgxn_c7124617b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

