module 0x6e2cd2c77df7a5771ca923bbd269d091c5bba673d1365943f96ea1f2baeed35b::brusui {
    struct BRUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUSUI>(arg0, 6, b"BRUSUI", b"Bruce Sui", b"ENTER THE BLOCKCHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050736_b73b51ac8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

