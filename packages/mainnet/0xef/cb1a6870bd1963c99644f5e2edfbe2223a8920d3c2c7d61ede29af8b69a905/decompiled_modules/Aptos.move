module 0xefcb1a6870bd1963c99644f5e2edfbe2223a8920d3c2c7d61ede29af8b69a905::Aptos {
    struct APTOS has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<APTOS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<APTOS>>(0x2::coin::split<APTOS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: APTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APTOS>(arg0, 6, b"APTOS", b"Another Phising Token On Sui", b"Another Phising Token On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/vBLX3d4n/Aptos-mark-BLK.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<APTOS>>(0x2::coin::mint<APTOS>(&mut v2, 8000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APTOS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<APTOS>>(v2);
    }

    // decompiled from Move bytecode v6
}

