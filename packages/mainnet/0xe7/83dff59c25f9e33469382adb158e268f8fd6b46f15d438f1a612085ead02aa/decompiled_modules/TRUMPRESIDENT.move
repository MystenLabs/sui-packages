module 0xe783dff59c25f9e33469382adb158e268f8fd6b46f15d438f1a612085ead02aa::TRUMPRESIDENT {
    struct TRUMPRESIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPRESIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPRESIDENT>(arg0, 9, b"TRUMPRESIDENT", b"TRUMPRESIDENT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPRESIDENT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMPRESIDENT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPRESIDENT>>(0x2::coin::mint<TRUMPRESIDENT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

