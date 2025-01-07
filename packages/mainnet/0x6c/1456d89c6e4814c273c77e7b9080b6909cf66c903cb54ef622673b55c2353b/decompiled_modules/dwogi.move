module 0x6c1456d89c6e4814c273c77e7b9080b6909cf66c903cb54ef622673b55c2353b::dwogi {
    struct DWOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOGI>(arg0, 6, b"DWOGI", b"DOG OF SUI", b"AT FIRST, THE EXPERIENCE WAS WILD AND CRAZY, WITH COLORS AND SHAPES DANCING IN HIS VISION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_1049889493.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

