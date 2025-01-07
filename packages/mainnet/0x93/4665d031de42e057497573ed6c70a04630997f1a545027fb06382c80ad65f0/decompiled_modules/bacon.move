module 0x934665d031de42e057497573ed6c70a04630997f1a545027fb06382c80ad65f0::bacon {
    struct BACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACON>(arg0, 6, b"BACON", b"Freddy The Bacon", x"4672656464792069732064656469636174656420666f7220616c6c20746865206261636f6e206c6f76657273206f75742074686572652c20636f7573652077686174277320626574746572207468616e206261636f6e3f200a4d617962652061204261636f696e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_b572c24aaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACON>>(v1);
    }

    // decompiled from Move bytecode v6
}

