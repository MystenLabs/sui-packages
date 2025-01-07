module 0x2dc6db80406ad5bb822e304baed0fb1d22c221debce240ae2b877d641cb6cfa9::onesui {
    struct ONESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONESUI>(arg0, 6, b"Onesui", b"OneSui", b"we will be No1 memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gg_W7lbja0_A_Aj_T_T_d996008026.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

