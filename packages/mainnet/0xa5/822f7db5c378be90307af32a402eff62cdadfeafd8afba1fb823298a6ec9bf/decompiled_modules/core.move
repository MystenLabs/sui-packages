module 0xa5822f7db5c378be90307af32a402eff62cdadfeafd8afba1fb823298a6ec9bf::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 9, b"HHS", b"HammerHead", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://magenta-protestant-falcon-171.mypinata.cloud/ipfs/QmNb1caN8xkkdGJEqLa3wuqtF5wS7AwLjpWk3bD1Uh7Ue8")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CORE>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORE>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

