module 0x6d22f99c7621c68193547e08113f6e863448750a715517530542941a93597fa4::fic {
    struct FIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIC>(arg0, 6, b"FIC", b"Fish in condom", b"It's a fish. in a condom. the lore is insane. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_28_5347dbb413.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

