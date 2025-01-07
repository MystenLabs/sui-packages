module 0xcc9eed97d5baef7bdb456df371bcc87adab015cba808f808a91d0fc7f3bb7fe1::lunchly {
    struct LUNCHLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNCHLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNCHLY>(arg0, 6, b"LUNCHLY", b"Sui Lunchly", b"Meet $LUNCHLY, The official Lunchly on Sui. Cheese always stays drippy on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/character_40b93a08_9c2eff677e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNCHLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNCHLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

