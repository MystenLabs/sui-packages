module 0x53705009336901ba169823def907edd39e52929ce53ff1a42f55764db4cbbbf7::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 6, b"FUD", b"Fud The Pug", b"$FUD is the community coin for Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954332887.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

