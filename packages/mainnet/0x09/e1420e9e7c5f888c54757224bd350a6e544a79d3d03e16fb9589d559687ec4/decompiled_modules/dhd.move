module 0x9e1420e9e7c5f888c54757224bd350a6e544a79d3d03e16fb9589d559687ec4::dhd {
    struct DHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHD>(arg0, 6, b"DHD", b"Diamond Hand Doge", x"4469616d6f6e642048616e6420446f67652028444844293a20436f6d62696e696e672074686520737472656e677468206f66206469616d6f6e642068616e64732077697468207468652062656c6f76656420446f67652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Rove6_T31_Re_N_Qhtp_FEU_566_K3z4m_A5_Bo_Nxd_Djwcc_NEU_Hs_61c0113820.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

