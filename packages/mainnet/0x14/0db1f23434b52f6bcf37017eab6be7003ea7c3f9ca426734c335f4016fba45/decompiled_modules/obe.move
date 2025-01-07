module 0x140db1f23434b52f6bcf37017eab6be7003ea7c3f9ca426734c335f4016fba45::obe {
    struct OBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBE>(arg0, 6, b"OBE", b"Out of Body Experience", b" OBE - Out of Body Experience  | Where mystery meets innovation  | Transcend the ordinary. Unlock the extraordinary. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ka_Ymy_U_Ur_400x400_fb39af75b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

