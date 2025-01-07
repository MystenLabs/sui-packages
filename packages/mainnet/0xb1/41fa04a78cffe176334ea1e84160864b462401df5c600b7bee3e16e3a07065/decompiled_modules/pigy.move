module 0xb141fa04a78cffe176334ea1e84160864b462401df5c600b7bee3e16e3a07065::pigy {
    struct PIGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGY>(arg0, 9, b"PIGY", b"PIGY", b"PIGY DO IT MAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/020/402/020/original/pigy-bank-finance-icon-ilustrations-logo-free-vector.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIGY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

