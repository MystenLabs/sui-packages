module 0xbd403c0c9c4f187a39072a286ef6004ded3310a2a8571a0efcb989ba328e5497::bpos {
    struct BPOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPOS>(arg0, 6, b"BPOS", b"Baby Pi on Sui", b"Pioneers on SUI let's show who the DADDY is.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5805691338103047576_f58d20ed31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

