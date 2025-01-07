module 0x615136e24536055feba88ba571dc75f362829de7c5281051b8762fe8024e3c79::pulici {
    struct PULICI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULICI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULICI>(arg0, 6, b"PULICI", b"PULICI", b"From 0 to 10 million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/JdE-7vjDUz0AAAAC/halopulici-pulici.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PULICI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULICI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULICI>>(v1);
    }

    // decompiled from Move bytecode v6
}

