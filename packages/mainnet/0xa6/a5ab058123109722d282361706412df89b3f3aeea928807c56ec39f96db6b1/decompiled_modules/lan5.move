module 0xa6a5ab058123109722d282361706412df89b3f3aeea928807c56ec39f96db6b1::lan5 {
    struct LAN5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN5>(arg0, 9, b"LAN5", b"LAN005", b"005", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.etsystatic.com/10192962/r/il/c9174a/1305091701/il_fullxfull.1305091701_2838.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN5>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN5>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN5>>(v2);
    }

    // decompiled from Move bytecode v6
}

