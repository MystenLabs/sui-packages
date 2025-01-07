module 0x3902f3ff52e63bce048b9590d205f4658816a42d006cabd885899d76995439af::lambow {
    struct LAMBOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBOW>(arg0, 6, b"LAMBOW", b"SUI LAMBOW", b"$LAMBOW is joining the mission to bring users onchain with sui We are team of experienced marketers and business professionals who are building something big!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jv9n2_GC_4_400x400_ff1bbee33b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMBOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

