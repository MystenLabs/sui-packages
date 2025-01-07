module 0x82b093befa9f43e6f07ab25a6439fb2bf85194dc21eab5bb274b6e9414d8fb14::fixy {
    struct FIXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIXY>(arg0, 6, b"FIXY", b"Sui Fixy", b"Fixy is coming, a memecoin culture full of goodness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001232_57c9f400d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

