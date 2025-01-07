module 0x21116811537cbbf3ee671b9afbc1de7d1a3775d1862fa41995bede278990ba80::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO", b"FomoBullClub", b"$FOMO The memecoin that never die is now at SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JSS_0_R1_J0_400x400_f3ae80a465.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

