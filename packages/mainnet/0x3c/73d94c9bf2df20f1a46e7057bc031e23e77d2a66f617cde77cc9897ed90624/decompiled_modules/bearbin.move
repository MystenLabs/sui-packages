module 0x3c73d94c9bf2df20f1a46e7057bc031e23e77d2a66f617cde77cc9897ed90624::bearbin {
    struct BEARBIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARBIN>(arg0, 6, b"BEARBIN", b"Sui Bearbin", x"546869732062656172206d6179206c6f6f6b207665727920646972747920616e6420636172656c6573732c2062757420686520697320746865206265737420696e766573746f722e20486973206f666669636520697320696e206120676172626167652064756d702e20576861742061726520796f750a77616974696e6720666f7220746f20627579204245415242494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028671_b3533b875c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARBIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARBIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

