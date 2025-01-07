module 0x3ac0aadb4078361a2eb767756120fdc09dbae2d6b60242ee9d9488344802d420::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Gongsui", b"Gongsui Token is a cryptocurrency designed for use within a blockchain-based ecosystem. It serves as a medium of exchange, governance participation, or utility token, enabling transactions, staking, and access to platform services. It may also provide incentives to active users within the project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/17296508523746ah0sstw_b03c6859b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

