module 0x720e4ce61c06607929a637abe6098ea5f6d466a774994801d51078a845eed15b::gnon {
    struct GNON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNON>(arg0, 6, b"GNON", b"SUI GNON", b"https://x.com/lumpenspace/status/1846085456724975998", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Jm2_Ya_XIA_Afvg_K_237bf54f2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNON>>(v1);
    }

    // decompiled from Move bytecode v6
}

