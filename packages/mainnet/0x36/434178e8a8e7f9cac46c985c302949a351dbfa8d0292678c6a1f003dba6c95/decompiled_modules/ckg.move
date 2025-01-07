module 0x36434178e8a8e7f9cac46c985c302949a351dbfa8d0292678c6a1f003dba6c95::ckg {
    struct CKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKG>(arg0, 9, b"CKG", b"Little Chipmunk Girl", b"She's a little chipmunk girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J7hYihB.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CKG>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKG>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

