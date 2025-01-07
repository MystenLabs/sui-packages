module 0xe035a377a860e3081ac049148c73502d86037e58c798d751695baae54dffbe15::mpt {
    struct MPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPT>(arg0, 9, b"TRUMP", b"trump", b"This is a token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreic5rvww44r365h66omnrhxft5fsz7v4cliq45xbiv4d4g7isbl7sm?X-Algorithm=PINATA1&X-Date=1732044287&X-Expires=315360000&X-Method=GET&X-Signature=d0e11a9e724be4a3300fb4fa9bc4a867e7908efbc0726fdc1cc2d08cccdf26d6"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MPT>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MPT>>(v2);
    }

    // decompiled from Move bytecode v6
}

