module 0xb01b391c16cedc1570affbb6eaac26e1f06601e47be43cd8167ec90edc3b7e36::bison {
    struct BISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISON>(arg0, 9, b"BISON", b"Gloom Bison", b"Gloom Bison is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/793/706/large/pedro-yang-tbrender-037.jpg?1728521099")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BISON>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISON>>(v1);
    }

    // decompiled from Move bytecode v6
}

