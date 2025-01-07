module 0x8f38e2e8604554a57bb4e2b635d298c9e66017e66334547dd940cae4121c523b::dracelon {
    struct DRACELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRACELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRACELON>(arg0, 6, b"Dracelon", b"Drac", b"meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_13_eb3799b88d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRACELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

