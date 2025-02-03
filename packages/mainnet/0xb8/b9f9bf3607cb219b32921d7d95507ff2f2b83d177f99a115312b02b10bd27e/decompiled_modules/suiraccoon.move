module 0xb8b9f9bf3607cb219b32921d7d95507ff2f2b83d177f99a115312b02b10bd27e::suiraccoon {
    struct SUIRACCOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRACCOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRACCOON>(arg0, 9, b"Suiraccoon", b"SUI Raccoon", b"The smartest raccoon at SUI trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5328ea0f6a031d4a3ea267516d3474c4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRACCOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRACCOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

