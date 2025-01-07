module 0xcee4c9637356d022429e5e0bfee545fe42a1022de5da75ba0a02ed3223a71855::noa {
    struct NOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOA>(arg0, 6, b"Noa", b"NoahTheDog", b"NOAH is the most beautiful dog meme that has been created so far on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5791731861167394124_y_2fd35a0f51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

