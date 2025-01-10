module 0x1bbe4f94ca6a3d6b258dad6c4be6b5200745190671f0d3310104f13667b3828::moverug {
    struct MOVERUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVERUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVERUG>(arg0, 6, b"MoveRug", b"Move Rug", x"53544f50205448452052554747494e47204f4e204d4f564550554d5021200a5745204150455320444553455256452042455454455221200a5245564f4c5554494f4e204e4f5721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9286_b520852566.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVERUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVERUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

