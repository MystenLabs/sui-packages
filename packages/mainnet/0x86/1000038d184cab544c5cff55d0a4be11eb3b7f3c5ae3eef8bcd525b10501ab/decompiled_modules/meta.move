module 0x861000038d184cab544c5cff55d0a4be11eb3b7f3c5ae3eef8bcd525b10501ab::meta {
    struct META has drop {
        dummy_field: bool,
    }

    fun init(arg0: META, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776357532661-46e5f0ddaf96a2cfdc29360e91d85ba8.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776357532661-46e5f0ddaf96a2cfdc29360e91d85ba8.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<META>(arg0, 9, b"META", b"Meta Pool", b"The Meta Pool it's Live", v1, arg1);
        let v4 = v2;
        if (10000000000000000 > 0) {
            0x2::coin::mint_and_transfer<META>(&mut v4, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<META>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<META>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

