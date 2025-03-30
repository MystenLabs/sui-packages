module 0xbe801800df85683f1965209864fcd72c2c1d7f11ca8fef7d4300d62c81559a0b::lemon {
    struct LEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMON>(arg0, 9, b"LEMON", b"LEMONY", b"Lemon (LMN) is more than just a cryptocurrency - it's a slice of innovation that's about to disrupt the status quo! Our team has worked tirelessly to create a coin that's not only secure and reliable but also community-driven and accessible. With Lemon, you'll experience the thrill of being part of a vibrant ecosystem that's pushing the boundaries of what's possible in the world of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/71973fa04b7637e98b5268e6c68359a4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

