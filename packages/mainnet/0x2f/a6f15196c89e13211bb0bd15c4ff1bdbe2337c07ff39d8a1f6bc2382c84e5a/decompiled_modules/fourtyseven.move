module 0x2fa6f15196c89e13211bb0bd15c4ff1bdbe2337c07ff39d8a1f6bc2382c84e5a::fourtyseven {
    struct FOURTYSEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOURTYSEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOURTYSEVEN>(arg0, 6, b"FourtySeven", b"47th President", b"47th president ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trumpm_ed8d5a30c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOURTYSEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOURTYSEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

