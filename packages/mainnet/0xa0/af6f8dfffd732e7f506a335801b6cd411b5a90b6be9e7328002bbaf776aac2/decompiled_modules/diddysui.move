module 0xa0af6f8dfffd732e7f506a335801b6cd411b5a90b6be9e7328002bbaf776aac2::diddysui {
    struct DIDDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDYSUI>(arg0, 6, b"DIDDYSUI", b"Diddys Island", x"61696e2774206e6f207061727479206c696b652061206469646479207061727479210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uf8_N_2_EL_400x400_a41259e70e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

