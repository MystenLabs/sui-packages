module 0xdc99c2f752a02fcac5c305a61c13a492c2456143751d1451c15997e6aa279132::sims {
    struct SIMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMS>(arg0, 6, b"SIMS", b"SUIMPSONS", b"The Suimpsons is known for accurately and shockingly predicting some significant events. The Sui ecosystem take over the crypto space and emerge as top player. Embrace the future by buying the SUIMPSONS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimp_111_b520278bfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

