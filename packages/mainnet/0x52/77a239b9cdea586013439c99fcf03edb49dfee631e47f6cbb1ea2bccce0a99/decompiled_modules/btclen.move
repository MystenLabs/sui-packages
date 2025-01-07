module 0x5277a239b9cdea586013439c99fcf03edb49dfee631e47f6cbb1ea2bccce0a99::btclen {
    struct BTCLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCLEN>(arg0, 6, b"BTCLEN", b"Len SassamanBTC", b"Creator of $BTC  Join the $LEN Revolution!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/creador_btc_2355166636.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCLEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCLEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

