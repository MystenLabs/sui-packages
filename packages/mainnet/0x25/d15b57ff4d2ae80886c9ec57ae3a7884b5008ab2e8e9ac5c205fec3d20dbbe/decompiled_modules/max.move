module 0x25d15b57ff4d2ae80886c9ec57ae3a7884b5008ab2e8e9ac5c205fec3d20dbbe::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 6, b"MAX", b"MAX", b"I'm Max", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-oraim8c9d1nkfuQk9EzGYEUGxqL3MHQYndRw1huVo5h-97.png/type=default_350_0?v=1734713448472&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAX>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

