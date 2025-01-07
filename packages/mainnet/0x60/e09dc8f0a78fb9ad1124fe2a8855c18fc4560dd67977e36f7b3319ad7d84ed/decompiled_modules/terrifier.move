module 0x60e09dc8f0a78fb9ad1124fe2a8855c18fc4560dd67977e36f7b3319ad7d84ed::terrifier {
    struct TERRIFIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERRIFIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERRIFIER>(arg0, 6, b"Terrifier", b"Art The Clown", b"Meet Art. He's a Naughty Clown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/terrifier_art_the_clown_ec29202d7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERRIFIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERRIFIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

