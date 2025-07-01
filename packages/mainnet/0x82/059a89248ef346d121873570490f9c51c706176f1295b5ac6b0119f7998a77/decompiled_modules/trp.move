module 0x82059a89248ef346d121873570490f9c51c706176f1295b5ac6b0119f7998a77::trp {
    struct TRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRP>(arg0, 6, b"TRP", b"Tump", b"Tump the war", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiarm5jbvbarzuoujbjfqoi74vz4qqrh3bmirrfxf62j2zs3bri3wq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

