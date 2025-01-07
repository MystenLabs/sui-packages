module 0x3e91d076e577850979fd44ce6d2775f56b65d1f59891e7e907757dd0b593d21e::smurfswifguns {
    struct SMURFSWIFGUNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFSWIFGUNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFSWIFGUNS>(arg0, 6, b"SMURFSWIFGUNS", b"SMURFS WIF GUNS", x"434f4d4d554e4954592054414b45204f56455220544f4b454e210a4e4f20534f4349414c532121200a53454e442054484953204d41544841462a434b41212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Polish_20241125_201306337_618cbddfc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFSWIFGUNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFSWIFGUNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

