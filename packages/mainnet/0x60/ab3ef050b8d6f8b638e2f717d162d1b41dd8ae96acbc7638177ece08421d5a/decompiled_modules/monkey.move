module 0x60ab3ef050b8d6f8b638e2f717d162d1b41dd8ae96acbc7638177ece08421d5a::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"Monkey Balls", b"2021 Wildlife photography comedy awards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MONKEY_207ded5b0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

