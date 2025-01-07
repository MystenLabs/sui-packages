module 0x8317756d25e73df9c35f867d03eac16cca06ba13bd31f2bff8562fc2bccd29e5::spam {
    struct SPAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAM>(arg0, 4, b"SPAM", b"SPAM", b"The original Proof of Spam coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPAM>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

