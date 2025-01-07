module 0x49182ee3a9885431bae15455eb9ef046f1c1feb99fed60585fc9a7770d88734f::solid {
    struct SOLID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLID>(arg0, 9, b"SOLID", b"STAY SOLID", b"KODAK BLACK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.scdn.co/image/ab67616d0000b273fb6748f2279e5ce67c36d50e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOLID>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLID>>(v1);
    }

    // decompiled from Move bytecode v6
}

