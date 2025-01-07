module 0x65d98a7f695e1e79378bb9b7a1b50e6c274f51adb3a2ed120eba50cab0cd69fa::SNAILPUMP {
    struct SNAILPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAILPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAILPUMP>(arg0, 6, b"SNAILPUMP", b"SNAILPUMP", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/PfGMvA2.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNAILPUMP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAILPUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAILPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

