module 0x26b2fd1df0c11b3bceec61da74776b8ac054443cc69042635fc7f6b7eed09d08::aptos {
    struct APTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: APTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APTOS>(arg0, 9, b"APTOS", b"Aptos", b"The World's Most Production-Ready Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.aptosfoundation.org/1684136828-favicon.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APTOS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APTOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

