module 0x20d1d61b896b562184732db3c63a81f4cae6564498dcde169b18582fb41c6da3::sapu {
    struct SAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPU>(arg0, 6, b"sApu", b"Sui Apu", b"Apu Apustaja dominated Solana and Ethereum, and now he's ready to reign supreme on the Sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/200x200_e7cd4c5f6e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

