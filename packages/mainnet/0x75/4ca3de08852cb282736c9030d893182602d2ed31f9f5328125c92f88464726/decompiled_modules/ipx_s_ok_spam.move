module 0x754ca3de08852cb282736c9030d893182602d2ed31f9f5328125c92f88464726::ipx_s_ok_spam {
    struct IPX_S_OK_SPAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_OK_SPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_OK_SPAM>(arg0, 9, b"ipx-s-ok-spam", b"iOK/SPAM", b"CLAMM Interest Protocol LpCoin for OK/SPAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_OK_SPAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_OK_SPAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

