module 0x5c131b8edf6702e2d75d85469fb97a561f76252c211ff31ebfef9c6ce97cc376::liars {
    struct LIARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIARS>(arg0, 6, b"LIARS", b"TODD VS HBO", b"Peter Todd will be looking at legal matters to sue HBO on defaming his name and bringing and ruining his privacy rights and he is ready to prove he is not Satoshi Nakamoto in court", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000824548_366ae94efa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

