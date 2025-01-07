module 0x7f61cb9fc41bf04550099a96ada928214427689c1ac630c57515ff3740d9fd2b::megg {
    struct MEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGG>(arg0, 6, b"MEGG", b"Sui Megg", b"$MEGG for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_61_5be8ec5074.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

