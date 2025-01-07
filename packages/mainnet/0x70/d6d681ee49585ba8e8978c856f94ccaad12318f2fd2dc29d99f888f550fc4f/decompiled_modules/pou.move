module 0x70d6d681ee49585ba8e8978c856f94ccaad12318f2fd2dc29d99f888f550fc4f::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POU>(arg0, 6, b"POU", b"POU on Sui", b"Just a Pou in a Pou world on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c1b1fc29a346e97974b9c53f7ad7ac27_ea5f107826.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POU>>(v1);
    }

    // decompiled from Move bytecode v6
}

