module 0xaed262db4478683011aa109ae3e1eecce4268b9751b414275a50c430cee761f::monk {
    struct MONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONK>(arg0, 9, b"Monk", b"Monk", b"The mon token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONK>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

