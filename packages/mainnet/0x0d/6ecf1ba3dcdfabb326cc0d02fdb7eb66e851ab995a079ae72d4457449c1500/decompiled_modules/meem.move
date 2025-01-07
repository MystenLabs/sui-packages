module 0xd6ecf1ba3dcdfabb326cc0d02fdb7eb66e851ab995a079ae72d4457449c1500::meem {
    struct MEEM has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEEM>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MEEM>>(0x2::coin::mint<MEEM>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: MEEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEM>(arg0, 9, b"MEEM", b"MEEM", b"MEEM or Meme no matter what is a degeneracy of porpotion never seen before is the way for big gains the only way to take us out of poverty,,,fair launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1856071908690964480/-y7H77bF_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEEM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

