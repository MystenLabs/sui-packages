module 0x910208da611afced98bcc7b5212801101086b586c319afdf545ad68115d51006::tb185e79f {
    struct TB185E79F has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TB185E79F>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TB185E79F>>(0x2::coin::mint<TB185E79F>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TB185E79F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TB185E79F>(arg0, 9, b"USAA", b"USAA", b"USAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/52kjYb4y/Screen-Shot-2026-07-27-231117-321.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TB185E79F>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TB185E79F>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

