module 0x8ceb1afe6e19c8d8939ce52b135c9711f0571fd7a89a2a4c98e13bf7ec8fee79::sagmi {
    struct SAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGMI>(arg0, 6, b"SAGMI", b"SUI ALL GOING to MAKE IT", b"SUI ALL GUNNA MAKE IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_14_57_15_bed4263124.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

