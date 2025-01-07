module 0xe22c9b758d4205bdcd6f6d7c470fcaff96037c7f47c45417ea609bb7f7c80980::slc {
    struct SLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SLC>(arg0, 6, b"SLC", b"Sui Lovers Club", b"Club for Sui lovers, holders, traders, just for fun of Sui community. Send Sui Lovers Club to the top in 2025. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Aida_c52272cb54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

