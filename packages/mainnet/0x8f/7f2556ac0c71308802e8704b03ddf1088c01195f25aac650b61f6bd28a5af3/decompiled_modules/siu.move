module 0x8f7f2556ac0c71308802e8704b03ddf1088c01195f25aac650b61f6bd28a5af3::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 9, b"SIU", b"SIU on SUI", x"6d7563686120677261636961732061666963696f6e206573746f206573207061726120766f736f74726f730a535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.batikanor.com/other/siu_on_sui.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIU>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v2, @0x414cfdb9f9fb8e2b812e8153156dff51aad6bc8dbacc13ebdd991f2e9e850fa0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

