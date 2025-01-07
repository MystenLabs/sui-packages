module 0x3008ed5958190448146f19d2f5000c9c1395bdb557fd0b52abfe67c52953dcd5::daram {
    struct DARAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARAM>(arg0, 6, b"Daram", b"Darams", b"@daram010", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039396_c2540f7de9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

