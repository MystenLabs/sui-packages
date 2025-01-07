module 0x71e58447a0ae5b31eca7818793645c342fde21b1500a1923d47ab9f45d393556::DOGWIFSUIT {
    struct DOGWIFSUIT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<DOGWIFSUIT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGWIFSUIT>>(arg0, arg1);
    }

    fun init(arg0: DOGWIFSUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFSUIT>(arg0, 9, b"SUIT", b"DOGWIFSUIT", b"It is literally a dog with a SUIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/28d8mzL/dogwifsuit.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<DOGWIFSUIT>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFSUIT>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGWIFSUIT>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGWIFSUIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGWIFSUIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

