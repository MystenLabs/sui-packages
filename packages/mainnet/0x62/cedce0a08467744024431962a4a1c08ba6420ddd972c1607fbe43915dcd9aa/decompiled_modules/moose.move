module 0x62cedce0a08467744024431962a4a1c08ba6420ddd972c1607fbe43915dcd9aa::moose {
    struct MOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSE>(arg0, 6, b"MOOSE", b"Moonshot MOOSE", b"Moonshot MOOSE means the Moonshot Opportunity Of SUI Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moonshot_moose_601_7644b6e05d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

