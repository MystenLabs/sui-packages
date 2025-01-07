module 0x8e5884d09809a2fd14ae1f4bb67799df05fa4514afa9fedf2451f4e79fc68d83::banksui {
    struct BANKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANKSUI>(arg0, 6, b"BANKSUI", b"Girl with SUI", b"There is always hope  (c)  Banksui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Banksui_09db97a3d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

