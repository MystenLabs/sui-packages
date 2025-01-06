module 0x1b64f6a5c3bcfde096ad558390404472beaaf56a55b8695e5fcefead0284ac17::suidepin {
    struct SUIDEPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEPIN>(arg0, 9, b"SUIDEPIN", b"Sui DePIN", b"A revolutionary network transforming billions of devices into a decentralized powerhouse for AI. It empowers data providers to own, control, and monetize their data, delivering quadrillions of reliable and sourced data points to fuel AI advancements.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/RO06bjNznXS3vSEzgXCQemqliA.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDEPIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDEPIN>>(0x2::coin::mint<SUIDEPIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIDEPIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

