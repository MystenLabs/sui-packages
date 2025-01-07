module 0x1802b3428edc16cab0a7c08bb89ee11b5f53b506b78dc1d2530eeafe895458e5::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"JOKER", b"Joker", x"244a6f6b65723a20466f6c69652020446575782c20204f6e6c7920696e2074686561746572732c204f63746f6265722034210a546865204a6f6b657220697320696e206368617267652c20496e74726f647563652061206c6974746c6520616e61726368792e205570736574207468652065737461626c6973686564206f726465722c20616e642065766572797468696e67206265636f6d6573206368616f732e2049276d20616e206167656e74206f66206368616f732e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe0797ec1d0bb0bec541a82c5262c3b0f93f68bfe_30c6f4de16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

