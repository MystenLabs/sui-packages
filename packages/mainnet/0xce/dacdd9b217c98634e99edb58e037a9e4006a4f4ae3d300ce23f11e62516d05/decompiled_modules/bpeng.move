module 0xcedacdd9b217c98634e99edb58e037a9e4006a4f4ae3d300ce23f11e62516d05::bpeng {
    struct BPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPENG>(arg0, 6, b"BPENG", b"Baby Peng", b"Introducing Baby Peng, the tiniest fluffball in the icy wonderland. Bundle up and join in the fun with Baby Peng.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001893_246d18c580.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

