module 0x60acdee5d6e9a18eb611012560f565514938ef5eb5c91eda5d833db443f02277::vct {
    struct VCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCT>(arg0, 9, b"VCT", b"Victor", b"LFG bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/db52918c657b3f9172fa82cba5e9cb60blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

