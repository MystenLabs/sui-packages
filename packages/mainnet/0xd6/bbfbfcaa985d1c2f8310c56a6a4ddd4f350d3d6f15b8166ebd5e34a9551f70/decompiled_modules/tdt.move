module 0xd6bbfbfcaa985d1c2f8310c56a6a4ddd4f350d3d6f15b8166ebd5e34a9551f70::tdt {
    struct TDT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TDT>, arg1: 0x2::coin::Coin<TDT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TDT>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TDT>>(0x2::coin::mint<TDT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDT>(arg0, 9, b"TDT", b"TDT", b"Test DAO token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbhnDgWMBc2Edo0UZhB3KBZSlvfDyxe8WMMQ&s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDT>>(v0, @0x611acbc2f87fc8a8064c7d3c3ccd2035d66e2ac69096bf03c45b0e70bffa53a);
    }

    // decompiled from Move bytecode v6
}

