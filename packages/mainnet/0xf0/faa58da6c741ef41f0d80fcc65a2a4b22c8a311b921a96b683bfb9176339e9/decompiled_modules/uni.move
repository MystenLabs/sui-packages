module 0xf0faa58da6c741ef41f0d80fcc65a2a4b22c8a311b921a96b683bfb9176339e9::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 9, b"Uni", b"Uni", b"Uni - Named after Sui co-founder Evan Cheng's dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://unicoinsui.com/logo_uni")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UNI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

