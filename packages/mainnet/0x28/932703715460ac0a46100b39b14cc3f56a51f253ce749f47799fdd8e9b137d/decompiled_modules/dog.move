module 0x28932703715460ac0a46100b39b14cc3f56a51f253ce749f47799fdd8e9b137d::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 9, b"DOG", b"DOGE", b"HOW HOW WAH ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/faec957deaaccea5c00e8e2f30286aceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

