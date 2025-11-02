module 0xa99f6af6fae579424c08f308cab7899949f9bcfd274bc933d62a6d64fc5d264::vence {
    struct VENCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENCE>(arg0, 9, b"VENCE", b"Vence Nigga", b"Vence Nigga - Launched on SuiLFG MemeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreigmjt6ryl32kpg5qm4s7hfwv45vynjz5w3d7uwgwtn2esktzzhgea")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VENCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

