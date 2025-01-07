module 0x314c064d6ff698ad5f192912bea8c3942849e42151ed1c4cd40a07ace1eb13b0::dpl {
    struct DPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPL>(arg0, 6, b"DPL", b"DogPool", b"The most famous dog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dogpool_62d05d15d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

