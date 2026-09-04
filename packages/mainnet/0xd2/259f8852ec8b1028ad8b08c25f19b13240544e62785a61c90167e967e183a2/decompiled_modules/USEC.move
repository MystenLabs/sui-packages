module 0xd2259f8852ec8b1028ad8b08c25f19b13240544e62785a61c90167e967e183a2::USEC {
    struct USEC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USEC>, arg1: 0x2::coin::Coin<USEC>) {
        0x2::coin::burn<USEC>(arg0, arg1);
    }

    public entry fun sender(arg0: &mut 0x2::coin::TreasuryCap<USEC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USEC>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: USEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USEC>(arg0, 9, b"USEC", b"USEC COIN", b"USEC is a US dollar-backed stablecoin issued by Circle. USEC is designed to provide a faster, safer, and more efficient way to send, spend, and exchange money around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.circle.com/hubfs/Brand/USEC/USEC_icon_32x32.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USEC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USEC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

