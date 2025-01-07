module 0xb139bea5d9df059911efb21a94eb0a3e9906f851826f40e0e8ae04520ee40d4b::bark {
    struct BARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARK>(arg0, 6, b"BARK", b"$BARK", b"I'm BARK, the #1 memecoin on $SUI the fastest in the whole doggo world! I Sniff out our airdrops and fetch some tail-wagging gains! $BARK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bk9_Aw_X_Xv_400x400_8ee8649dbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

