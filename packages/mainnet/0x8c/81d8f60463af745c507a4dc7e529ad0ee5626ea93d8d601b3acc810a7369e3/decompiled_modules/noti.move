module 0x8c81d8f60463af745c507a4dc7e529ad0ee5626ea93d8d601b3acc810a7369e3::noti {
    struct NOTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTI>(arg0, 6, b"NOTI", b"Nothing", b"Absolutely nothing on sui no twitter no telegram no website only community driven token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_at_12_06_00a_PM_e619d501cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

