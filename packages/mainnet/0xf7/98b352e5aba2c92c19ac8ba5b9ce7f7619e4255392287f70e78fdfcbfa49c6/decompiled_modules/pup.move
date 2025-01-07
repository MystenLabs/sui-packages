module 0xf798b352e5aba2c92c19ac8ba5b9ce7f7619e4255392287f70e78fdfcbfa49c6::pup {
    struct PUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUP>(arg0, 6, b"PUP", b"SUI PUP", b"https://bGet Your Paws on BesePup! The Crypto that's Too Cute to Resist! Earn, Rewards, Fun!asepup.fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbmbte_Nngqbx3_Qfe_Skc_PQCGW_Lt_DAL_Zv3_J_Tegd_Gtwa7_Bq8_ef817d1961.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

