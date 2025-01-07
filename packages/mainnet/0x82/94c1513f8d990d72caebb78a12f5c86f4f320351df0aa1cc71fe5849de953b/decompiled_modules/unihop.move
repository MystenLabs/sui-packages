module 0x8294c1513f8d990d72caebb78a12f5c86f4f320351df0aa1cc71fe5849de953b::unihop {
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

