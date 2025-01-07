module 0xc76708886723ca69725175c1ffc8f19cd32d108d27f6f66568fecd9cbc51713f::peli {
    struct PELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELI>(arg0, 6, b"PELI", b"Pelican", b"Water bird on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006275_c594ccd658.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELI>>(v1);
    }

    // decompiled from Move bytecode v6
}

