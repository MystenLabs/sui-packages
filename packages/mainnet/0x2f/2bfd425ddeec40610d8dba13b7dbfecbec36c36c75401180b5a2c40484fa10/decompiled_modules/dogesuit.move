module 0x2f2bfd425ddeec40610d8dba13b7dbfecbec36c36c75401180b5a2c40484fa10::dogesuit {
    struct DOGESUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUIT>(arg0, 6, b"DOGESUIT", b"DOGE COIN WITH SUIT", b"Doge is a very famous dog in the crypto world, now he has appeared on the SUI network wearing a beautiful and elegant suit. This dog will definitely bring you wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_192044823_e44b841dfb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGESUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

