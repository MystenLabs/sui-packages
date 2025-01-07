module 0x871295ba5b6c2849d9f8fa0738de1c44fea147e04aaf9b228f165344d9d40f38::hobo {
    struct HOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOBO>(arg0, 9, b"HOBO", b"Hobo Bobo", b"Do you have a Dollar ? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a3a4dcd2919f6f883e177307de3c9e3ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

