module 0x4c5e188d3e8c44fb18ca56db3cfe9f1d053849894b3a63c3dd17c9c058600799::uber {
    struct UBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBER>(arg0, 9, b"UBER", b"Uber COIN", b"New top coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f90324900d5d97b4011f474be457299eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UBER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

