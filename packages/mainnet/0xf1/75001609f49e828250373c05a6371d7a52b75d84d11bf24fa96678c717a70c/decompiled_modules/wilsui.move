module 0xf175001609f49e828250373c05a6371d7a52b75d84d11bf24fa96678c717a70c::wilsui {
    struct WILSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILSUI>(arg0, 6, b"WILSUI", b"WilsonSUI", b"Your friend WILSUI is always here for you. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3489_62f2520443.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

