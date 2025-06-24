module 0x439e037cd9705d6e9a8c0e0e798e7be16f4a6d25b9c4339dbc632af165219514::suipill {
    struct SUIPILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPILL>(arg0, 6, b"SUIPILL", b"Sui pill", b"Take the Sui pill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieufv4rh4oy6wedxejt6yb4yn3qkb4th7mis7474ts4rqlyel56xi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIPILL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

