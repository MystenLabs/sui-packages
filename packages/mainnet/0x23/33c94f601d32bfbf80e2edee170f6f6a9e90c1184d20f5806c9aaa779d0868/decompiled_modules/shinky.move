module 0x2333c94f601d32bfbf80e2edee170f6f6a9e90c1184d20f5806c9aaa779d0868::shinky {
    struct SHINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINKY>(arg0, 6, b"SHINKY", b"Shinky Sui", b"From the depths of the crypto seas, $Shinky emergesa half-dolphin, half-human legend on a mission to transform FISHES into WHALES.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056526_9d81bbc348.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

