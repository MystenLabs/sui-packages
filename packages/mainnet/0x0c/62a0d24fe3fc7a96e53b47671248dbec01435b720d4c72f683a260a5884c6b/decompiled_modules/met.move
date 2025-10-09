module 0xc62a0d24fe3fc7a96e53b47671248dbec01435b720d4c72f683a260a5884c6b::met {
    struct MET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MET>(arg0, 3, b"MET", b"metko", b"metko the cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MET>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MET>>(v2, @0x44981b0a8844f997572bbad92150256d10e7d3cbe3e0463814d601b25ac78333);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MET>>(v1);
    }

    // decompiled from Move bytecode v6
}

