module 0x8af8986327b65dfe3fea9e2090473f83ba00be3b9c1a099931848cad78148e35::csa {
    struct CSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSA>(arg0, 9, b"CSA", b"Csalab", b"The official Csalab token is on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://csalab.s3.ap-southeast-1.amazonaws.com/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CSA>(&mut v2, 13371337000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

