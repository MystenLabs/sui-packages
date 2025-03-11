module 0xf652ef5c9be31b8a4f23c5d42d6297fbc7e5a1d1f692ba67545a8523827da221::dogiz {
    struct DOGIZ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: 0x2::coin::Coin<DOGIZ>) {
        0x2::coin::destroy_zero<DOGIZ>(arg0);
    }

    fun init(arg0: DOGIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIZ>(arg0, 6, b"DOGIZ 2.0", b"Dogizen 2.0", x"496e73706972656420627920666f756e64657220506176656c204475726f76e280997320646f672c20446f67697a656e2069732064657369676e656420746f206b65657020667269656e647320636f6e6e656374656420616e6420746f676574686572207468726f75676820612066756e2067616d696e6720657870657269656e6365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dogizen.io/logo.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGIZ>>(0x2::coin::mint<DOGIZ>(&mut v2, 1000000000000000000, arg1), @0xd84c585ce80ab35b65c44c849cfd243e5e36ab846ba36241571f9d99e7a2cbd1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGIZ>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGIZ>>(v2);
    }

    // decompiled from Move bytecode v6
}

