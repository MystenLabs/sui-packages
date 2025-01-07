module 0x14051a3528bcb838d90a585c71d6b1b09d1295a71c022a146c111c473fa29de4::tot {
    struct TOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOT>(arg0, 6, b"TOT", b"Trick or Treat", b"Trick or Treat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c1b8e0db8216e0ad3651a76968765f1a_4a5995091f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

