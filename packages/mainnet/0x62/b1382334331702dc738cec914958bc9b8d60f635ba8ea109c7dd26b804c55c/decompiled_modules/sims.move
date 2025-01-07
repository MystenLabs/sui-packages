module 0x62b1382334331702dc738cec914958bc9b8d60f635ba8ea109c7dd26b804c55c::sims {
    struct SIMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMS>(arg0, 6, b"SIMS", b"SUIMPSONS", b"The Suimpsons is known for accurately and shockingly predicting some significant events. The Sui ecosystem take over the crypto space and emerge as top player. Embrace the future by buying the SUIMPSONS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimpsons_11111_56c70416dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

