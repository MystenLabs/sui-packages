module 0x560b224bb2848a576ddbb5675aecef49ab997744d64e22ed21e04047cf75c3c3::ttl {
    struct TTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTL>(arg0, 9, b"TTL", b"TURTLE", b"TURTLE WITH SALT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cf048ff-6e8c-42a3-9047-348edf5e67bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

