module 0x7d1424389eae13e613ede670ef52016e502843ea7b804ae9ad5e17627302e811::sp00ge {
    struct SP00GE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP00GE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP00GE>(arg0, 6, b"SP00GE", b"SP00GE", b"$SP00GE will make all of your dreams come true.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-34D7VCSA7uKsCHe5rRs5NpnkGRy7PW4g41asJnZ9pump-98.png/type=default_350_0?v=1735831285617&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SP00GE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SP00GE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP00GE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

