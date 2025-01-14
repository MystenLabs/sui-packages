module 0xdcdf74067eb65dbd1fc9b00858a0820e8d41cc9996e0013588706737c7c2d7d9::ms {
    struct MS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS>(arg0, 6, b"MS", b"MOONSUI", x"596f757665206a757374206c616e646564206f6e20746865206d6f6f6e206f6620706f73736962696c69746965732e205765206172652074616b696e6720626c6f636b636861696e2c206d656d65732c20616e6420696e6e6f766174696f6e20746f207468652073746172732e200a0a4c657473206275696c642067726561746e65737320746f6765746865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/972836fa_047d_414a_aa0d_fddc9f67358c_1d9a03b6c6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MS>>(v1);
    }

    // decompiled from Move bytecode v6
}

