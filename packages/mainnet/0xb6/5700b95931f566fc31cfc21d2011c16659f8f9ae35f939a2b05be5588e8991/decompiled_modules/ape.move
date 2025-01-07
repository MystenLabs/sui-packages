module 0xb65700b95931f566fc31cfc21d2011c16659f8f9ae35f939a2b05be5588e8991::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"ApeSui", b"Telegram: https://t.me/apesui_ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/uY9apzk.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, @0xaa2c6d0cd33f15a3b206d82ecde28e9ca6a4116bf1199905cb80ff75435c1955);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<APE>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

