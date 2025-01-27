module 0xbd51caf18b0ae905c31ace16c3e8ff5c764e7bb4da4a8e764de9d0e5a267f641::suijackjack {
    struct SUIJACKJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJACKJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJACKJACK>(arg0, 6, b"SUIJACKJACK", b"SUIJACK", b"your child superhero is ready to take you to the moon supermemecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jack_Jack_2d0195641f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJACKJACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJACKJACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

