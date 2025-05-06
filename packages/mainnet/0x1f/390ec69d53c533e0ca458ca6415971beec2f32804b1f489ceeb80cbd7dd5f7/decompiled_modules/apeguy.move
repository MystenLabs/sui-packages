module 0x1f390ec69d53c533e0ca458ca6415971beec2f32804b1f489ceeb80cbd7dd5f7::apeguy {
    struct APEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEGUY>(arg0, 6, b"APEGUY", b"Ape Guy", x"41706547757920686173207365656e20697420616c6c202d2062756c6c2072756e732c2062656172206d61726b6574732c20727567732c206861636b732c206465767320646973617070656172696e6720666f7220226f6e65206c617374207570646174652e222042757420646f6573206865207374726573733f204e61682e20486573206265656e206170696e67207468726f75676820697420616c6c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apeguy_logo_202e1a4343.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

