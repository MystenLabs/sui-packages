module 0x7379279761db2a1dac9999e8c660fa47015a1802c8034220ed9f672a837ae66a::watson {
    struct WATSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATSON>(arg0, 6, b"WATSON", b"Sui Watson", b"famous for its victory in the Jeopardy! quiz show, is also used in applications like healthcare and data analysis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Watson_pict_70e73acf93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

