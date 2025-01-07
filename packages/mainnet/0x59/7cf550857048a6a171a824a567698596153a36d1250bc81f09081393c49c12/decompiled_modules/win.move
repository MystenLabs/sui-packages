module 0x597cf550857048a6a171a824a567698596153a36d1250bc81f09081393c49c12::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 6, b"WIN", b"Mega Suillions", b"Make your crypto dreams of 1000x gains come true; when you buy a Mega Suillions ticket!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ticket_0e3184c464.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

