module 0x8f769057e06504d26edec78c93c4980b67b277d5dcb6b892d7bb6cca61c12418::suiiii {
    struct SUIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIII>(arg0, 6, b"Suiiii", b"CR7", x"437269737469616e6f20526f6e616c646f206f6e20537569207374726565740a4e756d62657220312043656c6562726974792d3e4e756d62657220312063656c656272697479204d656d6520746f6b656e0a314220534e5320666f6c6c6f7765722d3e3142204d61726b6574204361700a2a54686973206973206a7573742066616e20746f6b656e206e6f7420616666696c6961746564207769746820526f6e616c646f2a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiiiii_a07b9a1b97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

