module 0x8c2770ca88f84cece0c8dec316e12279660be44e3aebe75e2c859311b7992749::neirasui {
    struct NEIRASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRASUI>(arg0, 6, b"NeiraSui", b"NEIRA SUI", b"$NeiraSui, Neiro's woman, is arriving to ride the wave of the crypto market on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_001839_006_c20c20e9d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

