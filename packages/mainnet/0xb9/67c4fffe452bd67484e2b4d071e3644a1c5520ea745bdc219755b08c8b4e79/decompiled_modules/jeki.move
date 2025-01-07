module 0xb967c4fffe452bd67484e2b4d071e3644a1c5520ea745bdc219755b08c8b4e79::jeki {
    struct JEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEKI>(arg0, 6, b"JEKI", b"Sui Jeki", b"Spilling the tea with me is hard because I know all the tea ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_16_T201445_674_cb91efcbc4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

