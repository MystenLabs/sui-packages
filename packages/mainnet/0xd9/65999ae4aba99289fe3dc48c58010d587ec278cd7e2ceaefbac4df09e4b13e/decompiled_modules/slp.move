module 0xd965999ae4aba99289fe3dc48c58010d587ec278cd7e2ceaefbac4df09e4b13e::slp {
    struct SLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLP>(arg0, 6, b"SLP", b"Slepe", b"Lets SLEPE SUI together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_0b17573f68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

