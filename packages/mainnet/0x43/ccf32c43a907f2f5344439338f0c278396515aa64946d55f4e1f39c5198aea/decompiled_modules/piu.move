module 0x43ccf32c43a907f2f5344439338f0c278396515aa64946d55f4e1f39c5198aea::piu {
    struct PIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIU>(arg0, 6, b"PIU", b"PIU on SUI", x"50495520206973206b696e642c20647265616d7920616e642061206c6974746c65206e616976652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BW_8_G_LTL_400x400_ed594983d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

