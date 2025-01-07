module 0x23623681cf0c50747d72f6f4a22eeda37b841aba1851bd9ae61dd79d51e9542::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 9, b"BBC", x"f09fa9bb626f6d6261636c6174", b"bombaclat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

