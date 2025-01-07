module 0xe70b7d164f9da462eb0246afabaac2aae46b457a39fd6714f4fbc50ed91fee4f::eths {
    struct ETHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHS>(arg0, 9, b"ETHS", b"ETHSui", b"Ethereum on SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ETHS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

