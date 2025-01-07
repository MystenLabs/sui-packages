module 0x1b9a03620cf1d92cf4bce3b0fa038841ffdcd49eebaaedfc5b8d6c2957209fcf::hf {
    struct HF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HF>(arg0, 6, b"HF", b"hop fun", b"oh fuck,hop fun It's broken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_11_03_09_05_31_72c0cc2f72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HF>>(v1);
    }

    // decompiled from Move bytecode v6
}

