module 0x3458552d3eeedfcfab65b9ea50be0fa7a5269fc1398ba9ffec8b173f46dd8466::mnsry {
    struct MNSRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNSRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNSRY>(arg0, 6, b"MNSRY", b"Mansory On Sui", b"Mansory and Sui Lovers in the same place, IN MANSORY WE TRUST, IN SUI WE TRUST!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FONDO_BLANCO_9e11ba0ad4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNSRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNSRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

