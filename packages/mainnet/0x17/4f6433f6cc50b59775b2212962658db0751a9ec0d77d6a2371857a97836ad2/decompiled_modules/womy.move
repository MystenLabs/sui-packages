module 0x174f6433f6cc50b59775b2212962658db0751a9ec0d77d6a2371857a97836ad2::womy {
    struct WOMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMY>(arg0, 6, b"WOMY", b"SUI WOMY", b"$WOMY king of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_37_78b750ca44.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

