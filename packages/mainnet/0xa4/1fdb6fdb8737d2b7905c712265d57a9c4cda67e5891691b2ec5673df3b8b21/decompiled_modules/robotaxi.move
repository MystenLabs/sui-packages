module 0xa41fdb6fdb8737d2b7905c712265d57a9c4cda67e5891691b2ec5673df3b8b21::robotaxi {
    struct ROBOTAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTAXI>(arg0, 6, b"ROBOTAXI", b"RoboTaxi Sui", b"First Robotaxi on Sui | https://www.robotaxionsui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_P9_Qiq52_400x400_9227098853.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

