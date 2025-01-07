module 0xd206c040b5825a5722061e1eb613eb1c86d19382da77457f15a862bf455ce3b9::feen {
    struct FEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEEN>(arg0, 6, b"FEEN", b"Feen Story Sui", b"$FEEN  Live wild. Trade wicked. Cash in crazy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_075551_638_671f40fe97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

