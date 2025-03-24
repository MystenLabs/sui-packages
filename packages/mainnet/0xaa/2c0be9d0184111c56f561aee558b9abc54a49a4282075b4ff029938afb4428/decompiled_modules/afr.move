module 0xaa2c0be9d0184111c56f561aee558b9abc54a49a4282075b4ff029938afb4428::afr {
    struct AFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFR>(arg0, 9, b"AFR", b"AFR coin", b"Start  22.02.2022: ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d48c234b1019dd667c573d4dcf927e9cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

