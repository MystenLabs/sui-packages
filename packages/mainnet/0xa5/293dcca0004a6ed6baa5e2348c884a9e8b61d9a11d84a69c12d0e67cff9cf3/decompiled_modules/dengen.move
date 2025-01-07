module 0xa5293dcca0004a6ed6baa5e2348c884a9e8b61d9a11d84a69c12d0e67cff9cf3::dengen {
    struct DENGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGEN>(arg0, 6, b"DENGEN", b"Dengen Dengen", x"53757020796f75206c6f736572732c206d79206e616d6573202444454e47454e202e204920657363617065642074686520737475706964207a6f6f2077697468206d6f6f6e64656e6720616e642049277665206265656e2062616e6b696e67206f6e2073686974636f696e7320657665722073696e63652e204361746368206d6520696620796f752063616e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S49_K3ds_Y_400x400_12a5a31fb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

