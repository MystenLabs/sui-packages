module 0xee370790d1db0378859ad6de17108a40e7adf690c8beb5ae1da97dca5fbfb17a::tgt {
    struct TGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGT>(arg0, 6, b"TGT", b"TRUMP GOT TISM", x"492077696c6c206d616b65206120776f726c64206f66205449534d414e4945530a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732376389013.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

