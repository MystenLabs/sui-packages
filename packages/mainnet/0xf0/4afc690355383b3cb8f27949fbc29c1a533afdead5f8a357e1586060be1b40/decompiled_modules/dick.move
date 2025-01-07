module 0xf04afc690355383b3cb8f27949fbc29c1a533afdead5f8a357e1586060be1b40::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK>(arg0, 9, b"DICK", b"Suidick", b"The Most Ballsy Token on the SUI Blockchain  https://t.me/suidick https://www.suidick.xyz/ https://x.com/suidickofficial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729011525483-5b1785fe667e3442610eedc1fdbbd665.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DICK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK>>(v2, @0xb5d0aa57d26ade7ea602555cc3756cb1889323cff6fd25ab1704b708e912cae2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

