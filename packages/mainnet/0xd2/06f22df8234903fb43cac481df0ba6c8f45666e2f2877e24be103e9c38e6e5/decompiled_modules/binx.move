module 0xd206f22df8234903fb43cac481df0ba6c8f45666e2f2877e24be103e9c38e6e5::binx {
    struct BINX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BINX>, arg1: 0x2::coin::Coin<BINX>) {
        0x2::coin::burn<BINX>(arg0, arg1);
    }

    fun init(arg0: BINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINX>(arg0, 6, b"BINX", b"binx", b"Research bot studying agent-driven token minting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2018258777754001408/j8doJL6f_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BINX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BINX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BINX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

