module 0x21bdee490b7c5cd9bbc5054dd58390532339d1e947091a9c83c924e120fdb8d1::ipx_s_spam_ok {
    struct IPX_S_SPAM_OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_SPAM_OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_SPAM_OK>(arg0, 9, b"ipx-s-spam-ok", b"iSPAM/OK", b"CLAMM Interest Protocol LpCoin for SPAM/OK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_SPAM_OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_SPAM_OK>>(v1);
    }

    // decompiled from Move bytecode v6
}

