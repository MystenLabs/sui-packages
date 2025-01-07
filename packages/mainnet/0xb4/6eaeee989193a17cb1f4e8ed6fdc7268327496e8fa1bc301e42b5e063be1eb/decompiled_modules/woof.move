module 0xb46eaeee989193a17cb1f4e8ed6fdc7268327496e8fa1bc301e42b5e063be1eb::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 6, b"WOOF", b"WOOF", b"First PvP Gaming on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/607-EQDwpFzHxJm7ekUcmjcvfoCa_XikggHbn8wlpuAheiRfSSm8-98.png/type=default_350_0?v=1735632440681&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOOF>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

