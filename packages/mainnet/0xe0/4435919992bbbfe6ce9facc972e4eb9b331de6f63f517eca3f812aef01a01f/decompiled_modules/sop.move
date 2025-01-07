module 0xe04435919992bbbfe6ce9facc972e4eb9b331de6f63f517eca3f812aef01a01f::sop {
    struct SOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOP>(arg0, 6, b"SOP", b"Sui On Pepe", b"SuiPepe: The King of Memes on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepeee_8ef73d65d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

