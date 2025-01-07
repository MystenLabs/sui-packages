module 0xf176a3d263fdeafda25dc73da7bb9300e524a5d3ee0e664b6e63d1c337ba9aac::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 6, b"PAN", b"Panjeet", b"Panjeet is all about chill vibes while saying f**k the jeets, make you laugh and paying homage to the universal fix-all. Picture his kurta, sipping a hot cup, giving zero cares. Thats the energy Panjeet brings to the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c84dba30_aab4_42e2_b9d1_56bb32a56452_6c2d59cf1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

