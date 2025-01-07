module 0x5d56542e29b4288ba77245e1dc2dabdaaba8b09e94567d659c5eb233cb0860b5::eve {
    struct EVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVE>(arg0, 6, b"EVE", b"Eevee Sui", x"4565766565206465636964656420746f206465627574206f6e207375692c2064657465726d696e656420746f2066696e6420686973204f472e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_10_ced25275d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

