module 0x9dbdfc52a4538f2102b64bfd0dbf7391250005b74c57c01325d085ebff450e7b::tls {
    struct TLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLS>(arg0, 9, b"TLS", b"The Last of Sui", b"The last chance to sit in train.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TLS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

