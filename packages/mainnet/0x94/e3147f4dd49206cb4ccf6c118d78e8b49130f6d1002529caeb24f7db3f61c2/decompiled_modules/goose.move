module 0x94e3147f4dd49206cb4ccf6c118d78e8b49130f6d1002529caeb24f7db3f61c2::goose {
    struct GOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSE>(arg0, 6, b"GOOSE", b"BASED GOOSE", x"426173656420476f6f736520626c6573736573207468652053756920626c6f636b636861696e2c206d756c7469706c79696e672068697320626c657373696e677320627920313030782e20546f20656e72696368206c697665732077697468206865616c74682c207765616c74682c2068617070696e65737320616e64206162756e64616e63652e0a4c657420476f6f736520677569646520796f7520746f20756e706172616c6c656c65642070726f7370657269747920616e6420476f6f64206b61726d612e0a456d62726163652068697320776973646f6d200a4031303078474f4f53452028f09faabf2cf09faabf29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740338539924.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

