module 0x2b2da4bd2ae980f20a10e44240d1f8dd6cecb9812d3bc6bc56a1652cdcb70608::unihop {
    struct UNIHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIHOP>(arg0, 6, b"UNIHOP", b"UniHop", b"The dog of sui co-founder, Evan Cheng.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1111_2483bf2fe3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

