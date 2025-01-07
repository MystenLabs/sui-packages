module 0x41adedf2ebd79e4f4d86a6a85506f9cb5acf2587d6cd7a02ba180ff8eb724d53::asg {
    struct ASG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASG>(arg0, 6, b"Asg", b"asgar", b"fun go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735234406432.34")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

