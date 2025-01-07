module 0x8d2e97d0b2b6ef41c2dea0dfd35d53264532c2d77594b5b94aa3bad4460b885::soon {
    struct SOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOON>(arg0, 6, b"SOON", b"go to the moon soon", b"We're going to the moon soon!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/94c0323201dc2fea9ada15db1a06c8a_fe72b57ec2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

