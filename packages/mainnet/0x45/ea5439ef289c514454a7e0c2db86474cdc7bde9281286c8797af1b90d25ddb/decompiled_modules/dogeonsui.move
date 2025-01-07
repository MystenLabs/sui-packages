module 0x45ea5439ef289c514454a7e0c2db86474cdc7bde9281286c8797af1b90d25ddb::dogeonsui {
    struct DOGEONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEONSUI>(arg0, 6, b"DogeonSui", b"Doge on Sui", b"Doge on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOGEONSUI_FINAL_LOGO_8fc9867389.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

