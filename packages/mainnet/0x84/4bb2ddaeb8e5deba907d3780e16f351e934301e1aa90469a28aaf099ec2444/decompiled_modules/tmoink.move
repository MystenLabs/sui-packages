module 0x844bb2ddaeb8e5deba907d3780e16f351e934301e1aa90469a28aaf099ec2444::tmoink {
    struct TMOINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMOINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMOINK>(arg0, 6, b"TMOINK", b"TRUFFYMOINK", b"Tmoink is an ultimate fusion of charm, humor, and community-driven fun on the Sui blockchain Combining the sophistication of truffle hunting and the playful squeal of moink.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1734442840738_8e05cffef9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMOINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMOINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

