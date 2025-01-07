module 0x26ef4b84d9c51d578e0d758af25d0c38075daac0e8416f6df95a14acf62e00cc::skinut {
    struct SKINUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKINUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKINUT>(arg0, 6, b"SKINUT", b"Skimask Pnut", b"Skimask Pnut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.dexscreener.com/cms/images/TheeKX3wf_yDoWHh?width=56&height=56&fit=crop&quality=95&format=auto"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKINUT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKINUT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKINUT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

