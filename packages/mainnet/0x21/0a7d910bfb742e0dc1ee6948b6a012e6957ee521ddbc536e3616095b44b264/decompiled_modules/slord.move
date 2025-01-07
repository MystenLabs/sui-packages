module 0x210a7d910bfb742e0dc1ee6948b6a012e6957ee521ddbc536e3616095b44b264::slord {
    struct SLORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLORD>(arg0, 6, b"SLORD", b"Sui Lord", x"446f726b204c6f7264206f6e205355490a0a45786563757465204f726465722036392e2044657374726f7920746865204a656574692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/27992_73e3df6874.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

