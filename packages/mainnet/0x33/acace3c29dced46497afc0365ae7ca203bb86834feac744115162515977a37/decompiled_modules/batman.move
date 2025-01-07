module 0x33acace3c29dced46497afc0365ae7ca203bb86834feac744115162515977a37::batman {
    struct BATMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATMAN>(arg0, 9, b"BATMAN", x"f09fa687204241544d414e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/originals/4f/a1/41/4fa141173a1b04470bb2f850bc5da13b.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BATMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

