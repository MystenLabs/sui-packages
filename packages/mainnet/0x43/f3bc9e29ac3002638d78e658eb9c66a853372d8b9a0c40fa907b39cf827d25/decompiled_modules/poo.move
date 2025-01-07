module 0x43f3bc9e29ac3002638d78e658eb9c66a853372d8b9a0c40fa907b39cf827d25::poo {
    struct POO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POO>(arg0, 6, b"Poo", b"POO", b"Poo is person always thinks all will get shiit, life in shit world, shit friends and shit fams, now he want to check how shit crypto space..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241006_175641_657_bbbbc6a9ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POO>>(v1);
    }

    // decompiled from Move bytecode v6
}

