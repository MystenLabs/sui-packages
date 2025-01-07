module 0x5d4cff7d2791ae3ab42156ad67da5df0ecaca911284e35d637739929133d5d4b::komodo {
    struct KOMODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMODO>(arg0, 6, b"KOMODO", b"KOMODO DRAGONS", b"The One And Only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_1_f1a5e272c2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

