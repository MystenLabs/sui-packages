module 0xac71a94dcb3f22268410cfa6efa14dc9143980340dc14028e32ca0ccf58891e1::suiiii {
    struct SUIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIII>(arg0, 6, b"Suiiii", b"CR7", x"437269737469616e6f20526f6e616c646f206f6e20537569207374726565740a4e756d62657220312043656c6562726974792d3e4e756d62657220312063656c656272697479204d656d6520746f6b656e0a314220534e5320666f6c6c6f7765722d3e3142204d61726b657420436170", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiiiii_a07b9a1b97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

