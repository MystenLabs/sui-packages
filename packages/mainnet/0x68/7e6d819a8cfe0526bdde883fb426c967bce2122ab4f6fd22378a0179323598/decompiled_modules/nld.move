module 0x687e6d819a8cfe0526bdde883fb426c967bce2122ab4f6fd22378a0179323598::nld {
    struct NLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLD>(arg0, 9, b"NLD", b"NauticalDoubloon", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3xwvqyFVLN3GM0xGK5u5fH43dVtq8N863xQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NLD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

