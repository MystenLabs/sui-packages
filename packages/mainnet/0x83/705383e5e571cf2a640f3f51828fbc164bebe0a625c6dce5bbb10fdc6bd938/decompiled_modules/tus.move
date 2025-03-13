module 0x83705383e5e571cf2a640f3f51828fbc164bebe0a625c6dce5bbb10fdc6bd938::tus {
    struct TUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUS>(arg0, 9, b"TUS", b"TUSKYNAMESERVICE", b"tus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

