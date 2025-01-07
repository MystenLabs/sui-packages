module 0x6c16e11070e43aa8a6a41ad4f6723d0ea0487bfd8b0a5e972be8169cc22675db::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 9, b"wet", b"wetcat", b"This pussy is so wet! t.me/wetcatsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/7bDMoZ8.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WET>>(v1);
    }

    // decompiled from Move bytecode v6
}

