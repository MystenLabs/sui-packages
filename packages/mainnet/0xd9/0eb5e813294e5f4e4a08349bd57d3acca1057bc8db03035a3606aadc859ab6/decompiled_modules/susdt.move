module 0xd90eb5e813294e5f4e4a08349bd57d3acca1057bc8db03035a3606aadc859ab6::susdt {
    struct SUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDT>(arg0, 6, b"SUSDT", b"SUSDT", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSDT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUSDT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

