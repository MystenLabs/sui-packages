module 0xb1e3da64d62e5c9eca124aecfb79e6f75affe19a3f18719b16e033ea3944b0b::secret {
    struct SECRET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECRET>(arg0, 6, b"SECRET", b"Binance010101010101", x"3031303030303130203031313031303031203031313031313130203031313030303031200a3031313031313130203031313030303131203031313030313031203030313030303030200a3031313031313030203031313031313131203031313130313130203031313030313031200a3031313130303131203030313030303030203031313131303031203031313031313131200a3031313130313031", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/binance_f7b6f5d768.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECRET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SECRET>>(v1);
    }

    // decompiled from Move bytecode v6
}

