module 0x7e1ff0daf29eec60745bc91ceee4c944f1ebb1e909b9bd10d33f7382dd773c2b::suifrens {
    struct SUIFRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFRENS>(arg0, 6, b"Suifrens", b"Suifrens BullSharks", b"My SuiFren!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bullsharks_aaa71b218e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFRENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

