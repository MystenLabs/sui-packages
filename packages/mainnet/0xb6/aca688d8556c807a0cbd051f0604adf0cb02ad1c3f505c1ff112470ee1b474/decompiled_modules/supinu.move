module 0xb6aca688d8556c807a0cbd051f0604adf0cb02ad1c3f505c1ff112470ee1b474::supinu {
    struct SUPINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPINU>(arg0, 6, b"SUPINU", b"SUIPREME INU", b"The LORD has arrived on SUI - Meet SUPREME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ov_V3r_D26_400x400_1fda9b71ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

