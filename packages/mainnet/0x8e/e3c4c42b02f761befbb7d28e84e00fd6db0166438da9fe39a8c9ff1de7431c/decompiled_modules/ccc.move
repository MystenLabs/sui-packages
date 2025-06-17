module 0x8ee3c4c42b02f761befbb7d28e84e00fd6db0166438da9fe39a8c9ff1de7431c::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 9, b"CCC", b"CCC Token", b"Token CCC is da best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/86232569-e6c1-49af-910a-9aaffb3a703b.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CCC>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

