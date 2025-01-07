module 0x644b95798392a57e5a5b5bce32212a1c63bf7b44adbda3d4564ab7ffce6d1e85::MANA {
    struct MANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANA>(arg0, 9, b"MANA", b"MANA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MANA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MANA>>(0x2::coin::mint<MANA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

