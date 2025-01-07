module 0x1b01067a72b534c36de837bd86015488d3696208e42e1e6492ee5e1b5ecfadfc::snurky {
    struct SNURKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNURKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNURKY>(arg0, 6, b"Snurky", b"Snurky Sui", x"536e75726b79202d206973206120766567616e20736861726b2077686f20697320616761696e737420656174696e67206d6561742c20656e6a6f79732073757266696e6720616e6420636f666665650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sn_d47c0d351a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNURKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNURKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

