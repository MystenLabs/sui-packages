module 0x33b8662d21941e30bdd32ec51e3ead7e67b30907d50d2674250b6300f06c2cbd::warduck {
    struct WARDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARDUCK>(arg0, 6, b"WARDUCK", b"War Duck", b"War Duck pair launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4Mxx43UiIbIvt-QNsaUcwB43p87J74SoQuw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WARDUCK>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARDUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

