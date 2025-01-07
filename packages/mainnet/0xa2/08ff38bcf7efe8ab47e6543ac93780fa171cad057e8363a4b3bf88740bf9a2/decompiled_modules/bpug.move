module 0xa208ff38bcf7efe8ab47e6543ac93780fa171cad057e8363a4b3bf88740bf9a2::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"Baby Pug", b"Launching on Turbos.fun soon! Born from the OG, Fud the Pug, $BPUG is ready to steal the spotlight on Sui! With its cute but mischievous charm, Baby Pug is here to bark its way to the top, wagging tails and winning hearts along the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TURBOSFUN_PROFILE_2a74d6af98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

