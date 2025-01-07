module 0xe5b62a2871fa8005032480588e27b72b815da7a06a774616bb27bfc3864e3ebc::fpepe {
    struct FPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPEPE>(arg0, 6, b"FPEPE", b"Father Pepe on SUI", x"2446504550452054686520496e7465677269747920436f696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iurp2it_H_400x400_13dc8fa4fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

