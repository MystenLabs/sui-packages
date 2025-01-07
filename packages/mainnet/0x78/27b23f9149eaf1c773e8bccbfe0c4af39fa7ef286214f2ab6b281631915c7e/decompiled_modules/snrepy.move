module 0x7827b23f9149eaf1c773e8bccbfe0c4af39fa7ef286214f2ab6b281631915c7e::snrepy {
    struct SNREPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNREPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNREPY>(arg0, 6, b"SNREPY", b"Snrepy on Sui", b"Confusion, randomness, SNREPY is here. Play it or dont, its all about chill profits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2_300x300_f37b0621b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNREPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNREPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

