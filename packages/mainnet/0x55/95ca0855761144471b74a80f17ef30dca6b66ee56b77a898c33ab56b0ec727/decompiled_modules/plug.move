module 0x5595ca0855761144471b74a80f17ef30dca6b66ee56b77a898c33ab56b0ec727::plug {
    struct PLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUG>(arg0, 6, b"PLUG", b"PLUG SUI", b"Plug is determined to soak everyone who believes in Suis future. Plug can feel the power of the entire crypto community. Just enjoy the water and dont assign too much meaning to it. The person who opens Plugs valve for you is the silent Rebel, and Plug is very generous when in their hands. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ge_Ce_Wej_XMAE_Gw_Ty_fa38ddbcdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

