module 0x33c80f0df30b375446d4f085892ab0315001b0e1fb758521aea4b2c51997dbb6::sla {
    struct SLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLA>(arg0, 6, b"Sla", b"SLA", b"gggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/87193ae7-b588-4493-af87-eeec6f9c061f.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

