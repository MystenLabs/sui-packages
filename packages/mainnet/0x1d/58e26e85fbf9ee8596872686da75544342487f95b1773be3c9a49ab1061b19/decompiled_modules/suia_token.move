module 0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token {
    struct SUIA_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIA_TOKEN>, arg1: 0x2::coin::Coin<SUIA_TOKEN>) {
        0x2::coin::burn<SUIA_TOKEN>(arg0, arg1);
    }

    fun init(arg0: SUIA_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIA_TOKEN>(arg0, 9, b"SUIA", b"SUIA", b"SUIA is the native token of Suia.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreia2vfy4zap6plymncr37eeywxbno6zzfcchnrvrlys3rgbimx5w5a.ipfs.nftstorage.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIA_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIA_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIA_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIA_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

