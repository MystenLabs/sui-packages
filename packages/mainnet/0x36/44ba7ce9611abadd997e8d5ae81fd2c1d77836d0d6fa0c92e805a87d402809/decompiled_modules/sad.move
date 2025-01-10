module 0x3644ba7ce9611abadd997e8d5ae81fd2c1d77836d0d6fa0c92e805a87d402809::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"Sui Addict by SuiAI", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/adict_12b6a33e70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

