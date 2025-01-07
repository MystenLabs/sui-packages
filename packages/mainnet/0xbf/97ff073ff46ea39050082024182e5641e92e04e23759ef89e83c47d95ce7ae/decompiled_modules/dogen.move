module 0xbf97ff073ff46ea39050082024182e5641e92e04e23759ef89e83c47d95ce7ae::dogen {
    struct DOGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEN>(arg0, 6, b"DOGEN", b"DOGEN SUI", x"444f47454e206973206d6f7265207468616e206a75737420612063727970746f63757272656e63793b206974277320612073796d626f6c206f662066616974682c20636f6d6d756e69747920737472656e6774682c20616e642074686520756e7969656c64696e6720737069726974206f66206d656d652063756c747572652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gcg69u_OW_0_A_Au_Qxa_762e8775d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

