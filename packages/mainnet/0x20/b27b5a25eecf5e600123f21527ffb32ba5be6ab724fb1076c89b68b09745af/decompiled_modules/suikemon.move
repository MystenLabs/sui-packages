module 0x20b27b5a25eecf5e600123f21527ffb32ba5be6ab724fb1076c89b68b09745af::suikemon {
    struct SUIKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEMON>(arg0, 6, b"Suikemon", b"Catch 'em all on Sui", b"catch all the sui creatures with suikemon. the coins that launched are the suikemon characters in this sui-metaverse. what creatures are you going to catch with suikemon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_78a92b8b2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

