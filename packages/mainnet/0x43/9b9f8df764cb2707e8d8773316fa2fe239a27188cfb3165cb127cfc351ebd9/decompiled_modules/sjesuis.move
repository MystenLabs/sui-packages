module 0x439b9f8df764cb2707e8d8773316fa2fe239a27188cfb3165cb127cfc351ebd9::sjesuis {
    struct SJESUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJESUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJESUIS>(arg0, 6, b"SJesuis", b"Super Jesuis", b"Super Jesuis has arrived to the Sui Network. Together we will rise and protect Sui's ecosystem and rise through the ranks with the power of prayer!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BQ_Gh_EP_Jj_400x400_23f70afdab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJESUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJESUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

