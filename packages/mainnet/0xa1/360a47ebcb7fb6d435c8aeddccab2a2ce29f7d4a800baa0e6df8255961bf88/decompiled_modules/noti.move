module 0xa1360a47ebcb7fb6d435c8aeddccab2a2ce29f7d4a800baa0e6df8255961bf88::noti {
    struct NOTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTI>(arg0, 6, b"NOTI", b"Nothing", b"Absolutely nothing on Sui no twitter no website no telegram completely  community driven coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_at_12_06_00a_PM_fb8441c613.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

