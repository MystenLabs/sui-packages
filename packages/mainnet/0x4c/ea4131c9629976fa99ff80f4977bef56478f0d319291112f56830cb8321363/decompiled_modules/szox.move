module 0x4cea4131c9629976fa99ff80f4977bef56478f0d319291112f56830cb8321363::szox {
    struct SZOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZOX>(arg0, 6, b"Szox", b"SkullZox", b"The skull is made up of cranial bones (bones that surround and protect the brain) and facial bones (bones that form the eye sockets, nose, cheeks, jaw, and other parts of the face).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241014_093709_5db247366e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

