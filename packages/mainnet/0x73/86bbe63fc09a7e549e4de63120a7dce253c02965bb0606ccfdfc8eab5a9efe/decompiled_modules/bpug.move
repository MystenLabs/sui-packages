module 0x7386bbe63fc09a7e549e4de63120a7dce253c02965bb0606ccfdfc8eab5a9efe::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"Bpug", b"Baby Pug", b"Launching on Turbos.fun soon! Born from the OG, Fud the Pug, $BPUG is ready to steal the spotlight on Sui! With its cute but mischievous charm, Baby Pug is here to bark its way to the top, wagging tails and winning hearts along the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731289616726.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

