module 0xaacc52d7384b07dfce535a0b01847b76206f21915922cfd8fa9cad9f801ff955::est32 {
    struct EST32 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST32, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST32>(arg0, 6, b"EST32", b"testing11", b"dfs asfd a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1739371428316-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST32>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST32>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

