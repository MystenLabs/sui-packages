module 0xeb5f16a6f519caa7618624e3907e18b61c01b9077df6cd1f4cb8d3d9ac0bf8c4::mos {
    struct MOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOS>(arg0, 6, b"MOS", b"MaMeManOnSui", b"Welcome to Suinetwork, where MaMeMan and you create magic together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_9cc937404b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

