module 0x90a182040661cf8b9563a238501a44f56c49d1d36a04c346c0526f0b0d0bf3c7::dgen {
    struct DGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGEN>(arg0, 9, b"DGEN", b"DoGeElOn", b"Doge comes to Sui welcomes it...Trust me 3000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ac262483de34b66fe619816f4d8728f9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

