module 0x37d1ffd3d5f4dbf23daadad5b537c8623346ac68dd217234f1188e5f078c718a::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA>(arg0, 6, b"IKA", b"Ika", b"Ika official token launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752518681131.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

