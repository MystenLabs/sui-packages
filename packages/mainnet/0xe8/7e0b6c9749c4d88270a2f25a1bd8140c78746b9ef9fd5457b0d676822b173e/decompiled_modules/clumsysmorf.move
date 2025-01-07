module 0xe87e0b6c9749c4d88270a2f25a1bd8140c78746b9ef9fd5457b0d676822b173e::clumsysmorf {
    struct CLUMSYSMORF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUMSYSMORF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUMSYSMORF>(arg0, 6, b"Clumsysmorf", b"smurfcoin", b"smorfcoin is a memecoin in sui worlds .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_d5a91f90af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUMSYSMORF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUMSYSMORF>>(v1);
    }

    // decompiled from Move bytecode v6
}

