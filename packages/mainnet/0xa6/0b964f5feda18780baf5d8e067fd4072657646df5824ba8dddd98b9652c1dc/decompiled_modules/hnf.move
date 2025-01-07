module 0xa60b964f5feda18780baf5d8e067fd4072657646df5824ba8dddd98b9652c1dc::hnf {
    struct HNF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNF>(arg0, 6, b"HNF", b"Hop Not Fun", b"Hop is not fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hop_No_Fun_1_85bd7232c1_a41ca15867.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HNF>>(v1);
    }

    // decompiled from Move bytecode v6
}

