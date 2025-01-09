module 0x538be031d7597e5d87a5d084825fc4e113cf8750f36534d6dcaa121fa7b55297::suiz {
    struct SUIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZ>(arg0, 6, b"SUIZ", b"SUIZ Unicorn", b"$SUIZ  fam is on fire! Check out this epic creation from our communityproof that inspires more than just gains.  Keep the vibes coming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022536_4a63c95ff7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

