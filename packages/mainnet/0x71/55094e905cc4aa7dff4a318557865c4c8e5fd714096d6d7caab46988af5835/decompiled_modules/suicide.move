module 0x7155094e905cc4aa7dff4a318557865c4c8e5fd714096d6d7caab46988af5835::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUICIDE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICIDE>>(arg0, arg1);
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 9, b"SUICIDE", b"SUICIDE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gcdnb.pbrd.co/images/aV6OaPM0nxmm.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICIDE>(&mut v2, 18002738255000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

