module 0xcf0876e713788747f9a1025350db31285595a8d81d8d252e36246b7c530b59e3::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"POSEIDON", b"Blonde Poseidon", b"Blonde Poseidon  The chubby, hilarious ruler of the seas. With golden locks and a belly to match, this Poseidon brings waves of laughter and chaos to the Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ND_Nze2d_OQ_6_Wt_I_Sgzh_Lfe_IA_1_fffc95f31e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

