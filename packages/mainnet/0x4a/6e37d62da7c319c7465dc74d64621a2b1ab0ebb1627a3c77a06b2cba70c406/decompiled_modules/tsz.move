module 0x4a6e37d62da7c319c7465dc74d64621a2b1ab0ebb1627a3c77a06b2cba70c406::tsz {
    struct TSZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSZ>(arg0, 6, b"TSZ", b"IGUANA STYLE", b"The iguana learns how to eat face and it's interesting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iguana_7a6a4e2b9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

