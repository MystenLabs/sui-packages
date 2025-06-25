module 0xfcdc9ddf017d8a254da3cf5e75ad3553a1da020016fe77cb19b17977a8cf24d5::byh {
    struct BYH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYH>(arg0, 1, b"BYH", b"BAI", b"wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/0ab8c919-15d4-4a89-a74c-8b859c4baa50.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BYH>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYH>>(v1);
    }

    // decompiled from Move bytecode v6
}

