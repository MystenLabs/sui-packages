module 0xbe086411805fb6a84b79850f6c5e5be3d2476df245635ac03957d18668970050::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 6, b"DADDY", b"Daddy Tate", b"daddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PBH_8_B_Pxq_400x400_dc1af250e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

