module 0x691dbaa559f51f1fe623eef92d47e8cec9576315d191028af3ea57f75e25bea6::eid {
    struct EID has drop {
        dummy_field: bool,
    }

    fun init(arg0: EID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EID>(arg0, 6, b"EID", b"EID MUBARAK", x"454944204d55424152414b20544f20414c4c200a54484953204f4e452057494c4c204252414b4553204541545320414c4c2054494d4520484947482054574f2054494d4520494e20412059454152200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036560_eef0cd2ec5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EID>>(v1);
    }

    // decompiled from Move bytecode v6
}

