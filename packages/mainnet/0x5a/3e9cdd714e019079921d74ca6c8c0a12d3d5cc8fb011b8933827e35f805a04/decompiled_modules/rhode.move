module 0x5a3e9cdd714e019079921d74ca6c8c0a12d3d5cc8fb011b8933827e35f805a04::rhode {
    struct RHODE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RHODE>, arg1: 0x2::coin::Coin<RHODE>) {
        0x2::coin::burn<RHODE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RHODE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RHODE>>(0x2::coin::mint<RHODE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RHODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHODE>(arg0, 9, b"rhode", b"RHODE", b"test one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"example.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHODE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHODE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

