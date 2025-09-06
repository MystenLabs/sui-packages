module 0xcd9c34af2656e854ff3e92f9698ca184a52ecbe33fc471786321ac0e64033d14::nobuy {
    struct NOBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBUY>(arg0, 9, b"nobuy", b"test", b"afsdgsdgfgsdgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOBUY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBUY>>(v2, @0x877a03d7e53ff8c9c6dc96e76b6367f03884813b2aec6a360abba9dfe3c17781);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

