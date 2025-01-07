module 0x8418bdfdef4e1a0561505025c00cce0fc4f2a9a174852dd58c4966dd06419da3::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"SuidGameOnSui", b"In the high-stakes world of SUID Game, participants navigate deadly challenges within the SUI blockchain, ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_003707_6bb64e8f75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

