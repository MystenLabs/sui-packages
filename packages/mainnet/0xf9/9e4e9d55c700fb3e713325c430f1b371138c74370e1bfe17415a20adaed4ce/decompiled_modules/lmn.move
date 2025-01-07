module 0xf99e4e9d55c700fb3e713325c430f1b371138c74370e1bfe17415a20adaed4ce::lmn {
    struct LMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMN>(arg0, 9, b"LMN", b"Lemon", b"Fresh Lemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LMN>(&mut v2, 72000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

