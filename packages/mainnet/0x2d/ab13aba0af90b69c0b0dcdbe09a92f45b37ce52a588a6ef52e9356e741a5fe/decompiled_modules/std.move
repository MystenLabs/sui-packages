module 0x2dab13aba0af90b69c0b0dcdbe09a92f45b37ce52a588a6ef52e9356e741a5fe::std {
    struct STD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STD>(arg0, 6, b"STD", b"Suitard", b"tweet 'get me in lil turd' to get featured in the suitardio hall of fame | the ticker is $STD | A tribute to all retard(io)s on Sui | http://suitard.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suitard_60a585b71c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STD>>(v1);
    }

    // decompiled from Move bytecode v6
}

