module 0xf1d5d695489fddb6c07fbfdb9086d9e76b17939068165b03b968e282a1fe2812::speedlink {
    struct SPEEDLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEEDLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEEDLINK>(arg0, 9, b"SPEEDLINK", b"Speedo", b"We want the world to be faster, Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.speedlink.com/media/34/e8/93/1605257767/speedlink%20%283%29.svg?ts=1605257767")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPEEDLINK>(&mut v2, 300000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEEDLINK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEEDLINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

