module 0xc3db1530bd237487fae6986eefa2a79739beec518a0d442d73a6e26eeadf94d9::orbdog {
    struct ORBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBDOG>(arg0, 6, b"Orbdog", b"Orbeez Dog On Sui", b"$Orbdog is the most daring dog on the blockchain. He only eats Orbeez and Jeets, and the occasional bacon egg & cheese sandwich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nbat_LJ_Gg_Nmhe_Cgo4_Ma_Qif6_CEW_1o6_XD_Unfsa1ki91crqp_07e18aa2ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORBDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

