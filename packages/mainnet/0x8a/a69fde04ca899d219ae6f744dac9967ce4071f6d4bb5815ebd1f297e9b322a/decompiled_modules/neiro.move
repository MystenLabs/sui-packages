module 0x8aa69fde04ca899d219ae6f744dac9967ce4071f6d4bb5815ebd1f297e9b322a::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 9, b"Neiro", b"Neiro", b"Sui Neirooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/4mw5jbqvu6qrOu6kJ7Nni6VXJs.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEIRO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

