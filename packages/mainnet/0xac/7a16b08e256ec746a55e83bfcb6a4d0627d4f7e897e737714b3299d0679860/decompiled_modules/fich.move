module 0xac7a16b08e256ec746a55e83bfcb6a4d0627d4f7e897e737714b3299d0679860::fich {
    struct FICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FICH>(arg0, 6, b"FICH", b"fich coin", x"54484953204953202446494348205448450a53544f4e4b532046495348", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fich_coin_a0600545ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

