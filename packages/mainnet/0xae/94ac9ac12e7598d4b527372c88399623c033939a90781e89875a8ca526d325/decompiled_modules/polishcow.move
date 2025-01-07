module 0xae94ac9ac12e7598d4b527372c88399623c033939a90781e89875a8ca526d325::polishcow {
    struct POLISHCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLISHCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLISHCOW>(arg0, 6, b"POLISHCOW", b"Polish cow", b"Polish cow (POLISHCOW)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/546_bdbc8997a9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLISHCOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLISHCOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

