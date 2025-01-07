module 0x2a767646bba81a245b44ce6c9cdfd11c3e8d846e27c792ac759c6cf614701981::ssp {
    struct SSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSP>(arg0, 6, b"SSP", b"Starship", x"537461727368697020323033340a54686973206973206120626567696e6e696e67200a48617070656e73206f6674656e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088780_caec833b41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

