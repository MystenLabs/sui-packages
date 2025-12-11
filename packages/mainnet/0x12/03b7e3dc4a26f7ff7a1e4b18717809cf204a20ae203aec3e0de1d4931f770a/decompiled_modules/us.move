module 0x1203b7e3dc4a26f7ff7a1e4b18717809cf204a20ae203aec3e0de1d4931f770a::us {
    struct US has drop {
        dummy_field: bool,
    }

    fun init(arg0: US, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<US>(arg0, 9, b"US", b"0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US", b"The native token for the Talus Network. 0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://talus.network/us-icon.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<US>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<US>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<US>>(v1);
    }

    // decompiled from Move bytecode v6
}

