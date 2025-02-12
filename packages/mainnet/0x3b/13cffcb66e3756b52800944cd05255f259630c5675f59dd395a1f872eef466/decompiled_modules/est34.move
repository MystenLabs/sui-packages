module 0x3b13cffcb66e3756b52800944cd05255f259630c5675f59dd395a1f872eef466::est34 {
    struct EST34 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST34, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST34>(arg0, 6, b"EST34", b"testing322", b"sfasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1739371812268-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST34>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST34>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

