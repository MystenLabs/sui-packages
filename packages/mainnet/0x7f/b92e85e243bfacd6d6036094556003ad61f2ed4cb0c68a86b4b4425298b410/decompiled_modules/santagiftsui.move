module 0x7fb92e85e243bfacd6d6036094556003ad61f2ed4cb0c68a86b4b4425298b410::santagiftsui {
    struct SANTAGIFTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTAGIFTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTAGIFTSUI>(arg0, 6, b"Santagiftsui", b"Santa gift sui", b"Sui...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000905983_27678b6a2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTAGIFTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTAGIFTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

