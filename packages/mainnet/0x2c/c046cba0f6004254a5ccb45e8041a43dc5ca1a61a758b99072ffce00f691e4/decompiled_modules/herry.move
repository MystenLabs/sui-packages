module 0x2cc046cba0f6004254a5ccb45e8041a43dc5ca1a61a758b99072ffce00f691e4::herry {
    struct HERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERRY>(arg0, 6, b"HERRY", b"HERRRY POTTAH", b"The most magical memecoin in the wizarding world! Now on SUI blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiecpnlqxgu3cyqr2zpou67j57aptrsaxtuxblgqgdbglgzopoki44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HERRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

