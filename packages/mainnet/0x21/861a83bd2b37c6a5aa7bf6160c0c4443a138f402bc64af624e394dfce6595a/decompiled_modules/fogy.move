module 0x21861a83bd2b37c6a5aa7bf6160c0c4443a138f402bc64af624e394dfce6595a::fogy {
    struct FOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOGY>(arg0, 6, b"FOGY", b"Sui Fogy", b"$FOGY The cutest Frog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_43_4b9b55d579.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

