module 0xb52f3c18272f9763408526f58d2fb2239739ea08c0c3536b55f18370ccd4c34e::lugia {
    struct LUGIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGIA>(arg0, 6, b"LUGIA", b"Lugia Pokeball", b"The legendary pokemon ball Lugia will hatch as soon as the bond curve is completed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidwqwvb6vbddwm76xdspril5n5qeml7g4izzi4cgwfxh4fiijc6qq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUGIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

