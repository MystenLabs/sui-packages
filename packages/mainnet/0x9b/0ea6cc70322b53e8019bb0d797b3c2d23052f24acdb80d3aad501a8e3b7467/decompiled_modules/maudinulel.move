module 0x9b0ea6cc70322b53e8019bb0d797b3c2d23052f24acdb80d3aad501a8e3b7467::maudinulel {
    struct MAUDINULEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUDINULEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAUDINULEL>(arg0, 6, b"Maudinulel", b"Maudinu", b"Lets go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_ee800955c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAUDINULEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAUDINULEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

