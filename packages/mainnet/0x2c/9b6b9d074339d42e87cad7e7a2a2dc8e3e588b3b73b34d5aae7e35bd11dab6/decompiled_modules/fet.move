module 0x2c9b6b9d074339d42e87cad7e7a2a2dc8e3e588b3b73b34d5aae7e35bd11dab6::fet {
    struct FET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FET>(arg0, 9, b"FET", b"FETEAM", b"FE TEAM COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FET>>(v1);
    }

    // decompiled from Move bytecode v6
}

