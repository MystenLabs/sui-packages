module 0xf512deace97a1b68d2e7eeffce6ffb1ac753aa9963846bab5a5969651cba1598::duffy {
    struct DUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUFFY>(arg0, 6, b"DUFFY", b"Duffy on Sui", b"DUFFY - The dog in the hat on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001687_f1c84aeb2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

