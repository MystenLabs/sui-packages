module 0xc648732a0e040bf228ef35a0430ee58d0e4eb54c0b1fd52dac24733018b45076::ZALO {
    struct ZALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZALO>(arg0, 9, b"ZALO", b"ZALO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZALO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZALO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZALO>>(0x2::coin::mint<ZALO>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

