module 0x641887ebeab1389c12a6170e410f30afa9b80e4046153cedb4576d29205da53c::boopa {
    struct BOOPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOPA>(arg0, 9, b"Boopa", b"Boopa On Sui", b"Boopa is the trenchers pet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mainnet-boop.s3.us-east-1.amazonaws.com/JmMRbLcKgNCu17yHZDAn4strE5NjmWJ4pCeJ7s7boop/291c2e4d276caed75175e081d11bb55ceeb98cf923022d82514d9c232cbfab55.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOPA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOPA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

