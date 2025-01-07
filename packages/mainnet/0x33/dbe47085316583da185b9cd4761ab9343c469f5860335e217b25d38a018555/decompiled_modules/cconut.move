module 0x33dbe47085316583da185b9cd4761ab9343c469f5860335e217b25d38a018555::cconut {
    struct CCONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCONUT>(arg0, 6, b"Cconut", b"Coconut", b"Who don't like coconut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044828_20d7d6e687.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCONUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCONUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

