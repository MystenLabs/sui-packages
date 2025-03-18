module 0x62dc0700508ea21223a91188dac9c8ced04b76344e70b7ac14a016623f67e0dc::weo {
    struct WEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEO>(arg0, 9, b"Weo", b"Meo", b"kjnjkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cf7b63c270d0ab0ef869b39892454f4ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

