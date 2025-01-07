module 0x950e5131909ffd79cdeca0618ef5a20c2c7bf470ba29af82836843e7831e57d3::drns {
    struct DRNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRNS>(arg0, 6, b"DRNS", b"DRAGONSUI", b"Im the Dragon of Sui chain, RAWRRRRRRRRR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1n_D_Umwp_400x400_aa5c2867eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

