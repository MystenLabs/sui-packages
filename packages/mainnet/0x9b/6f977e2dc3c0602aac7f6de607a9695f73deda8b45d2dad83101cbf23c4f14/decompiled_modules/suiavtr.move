module 0x9b6f977e2dc3c0602aac7f6de607a9695f73deda8b45d2dad83101cbf23c4f14::suiavtr {
    struct SUIAVTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAVTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAVTR>(arg0, 6, b"SUIAVTR", b"SUIAVATAR", x"535549415641544152204f4e20544849532057415921210a4c4153542041495242454e44455220494e2043525950544f20574f524c440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196891_cd47df6c09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAVTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAVTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

