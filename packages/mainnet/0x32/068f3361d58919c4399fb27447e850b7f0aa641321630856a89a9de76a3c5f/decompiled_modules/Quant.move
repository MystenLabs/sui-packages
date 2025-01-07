module 0x32068f3361d58919c4399fb27447e850b7f0aa641321630856a89a9de76a3c5f::Quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<QUANT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<QUANT>>(0x2::coin::split<QUANT>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<QUANT>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<QUANT>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<QUANT>(arg0);
        };
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 9, b"QUANT ", b"Gen Z Quant", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmQM2jhqyG689v2fC1Het1p1fJVBMpSDnMkq4tvncYfyiV?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<QUANT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<QUANT>>(0x2::coin::mint<QUANT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

