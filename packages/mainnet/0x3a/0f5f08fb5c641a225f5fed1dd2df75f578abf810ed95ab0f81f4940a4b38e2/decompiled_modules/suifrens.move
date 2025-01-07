module 0x3a0f5f08fb5c641a225f5fed1dd2df75f578abf810ed95ab0f81f4940a4b38e2::suifrens {
    struct SUIFRENS has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIFRENS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIFRENS>>(arg0, arg1);
    }

    fun init(arg0: SUIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFRENS>(arg0, 1, b"AIFRENS", b"Sui Frens ai", b"Sui Fren AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/4OvqVCM.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIFRENS>(&mut v2, 2000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFRENS>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFRENS>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIFRENS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIFRENS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

