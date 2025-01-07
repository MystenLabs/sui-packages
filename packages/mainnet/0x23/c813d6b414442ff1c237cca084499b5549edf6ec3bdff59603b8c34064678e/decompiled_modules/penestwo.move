module 0x23c813d6b414442ff1c237cca084499b5549edf6ec3bdff59603b8c34064678e::penestwo {
    struct PENESTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENESTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENESTWO>(arg0, 6, b"PENESTWO", b"penes2.0", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"penes")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENESTWO>(&mut v2, 64848481000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENESTWO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENESTWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

