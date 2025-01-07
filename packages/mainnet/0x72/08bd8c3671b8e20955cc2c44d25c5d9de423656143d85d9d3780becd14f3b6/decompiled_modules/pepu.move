module 0x7208bd8c3671b8e20955cc2c44d25c5d9de423656143d85d9d3780becd14f3b6::pepu {
    struct PEPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPU>(arg0, 9, b"PEPU", b"Pudgy Pepe", b"The pudgiest fella on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/6QHkO0i8BvHPbC2KlXVYDkjFVJhYTMgwoh_uX33giJg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

