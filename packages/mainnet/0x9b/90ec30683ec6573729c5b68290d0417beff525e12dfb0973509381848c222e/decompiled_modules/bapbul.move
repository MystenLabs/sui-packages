module 0x9b90ec30683ec6573729c5b68290d0417beff525e12dfb0973509381848c222e::bapbul {
    struct BAPBUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPBUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPBUL>(arg0, 6, b"BAPBUL", b"BAPBUL On Sui", b"$BAPBUL is the cutest and viral dog on the internet, she's too adorable .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000158851_6da812cf01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPBUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPBUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

