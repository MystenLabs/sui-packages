module 0xc59620b0dce6e40efaea8d58a4efea895ecbc62b17f02fe305c7982eb5ef44cd::babyshark {
    struct BABYSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSHARK>(arg0, 9, b"BABYSHARK", b"Baby Shark", b"Baby Shark Tutututu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844409853680418819/97lDhQ_P.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSHARK>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSHARK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

