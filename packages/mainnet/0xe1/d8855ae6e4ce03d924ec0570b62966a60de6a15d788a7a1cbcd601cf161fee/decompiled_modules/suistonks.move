module 0xe1d8855ae6e4ce03d924ec0570b62966a60de6a15d788a7a1cbcd601cf161fee::suistonks {
    struct SUISTONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTONKS>(arg0, 6, b"SUISTONKS", b"Suistonks", b"GET READY SUI CHAIN!!! $SUISTONKS WILL BE UNBREAKABLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suistonk_smaller_text_49ec002cf0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

