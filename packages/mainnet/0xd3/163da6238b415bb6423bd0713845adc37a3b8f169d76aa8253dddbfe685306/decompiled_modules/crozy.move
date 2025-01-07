module 0xd3163da6238b415bb6423bd0713845adc37a3b8f169d76aa8253dddbfe685306::crozy {
    struct CROZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROZY>(arg0, 6, b"CROZY", b"Crozy Duck", b"$CROZY is the most unique Memecoin on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020683_f057eb3405.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

