module 0xadf0da4c2f03a49e11e5498c27f030189a333e635b024889421ca3c1459633e5::buff {
    struct BUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFF>(arg0, 9, b"BUFF", b"BUFFSUI", b"$BUFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUFF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

