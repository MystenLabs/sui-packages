module 0xdcd73162b42390e9ff474a11ea440e985d79fac7b31200760ece8e8f457f45e5::rg {
    struct RG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RG>(arg0, 6, b"RG", b"RedGifs on SUI", x"656e6a6f7920796f7572206661766f7269746520636f6e74656e742063726561746f72732e0a6e6f2074672c206e6f20782e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_24_204327_f9b3c877de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RG>>(v1);
    }

    // decompiled from Move bytecode v6
}

