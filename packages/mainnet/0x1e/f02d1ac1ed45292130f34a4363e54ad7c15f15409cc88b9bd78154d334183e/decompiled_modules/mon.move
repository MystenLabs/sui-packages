module 0x1ef02d1ac1ed45292130f34a4363e54ad7c15f15409cc88b9bd78154d334183e::mon {
    struct MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MON>(arg0, 9, b"Mon", b"Monad", b"Monad needs Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/36b2b7bfe22c7bf6eaec24894dcfdccablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

