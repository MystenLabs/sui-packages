module 0x184deec32e8f1a3d1981da477bc61978a39ee6b2e6fd5424f10a38d38fd53ff6::plutus {
    struct PLUTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUTUS>(arg0, 6, b"PLUTUS", b"Plutus AI", b"Unlock your potential, accelerate your finances, and transform the way you invest with our cutting-edge Al", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042026_ec8114461e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

