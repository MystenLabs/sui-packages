module 0x7f74f70e6b9b490fc6ae39adb41b1646ccbfd736beb014a7d291950f575b097::adam {
    struct ADAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAM>(arg0, 9, b"ADAM", b"Adam Token", b"A token called Adam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADAM>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

