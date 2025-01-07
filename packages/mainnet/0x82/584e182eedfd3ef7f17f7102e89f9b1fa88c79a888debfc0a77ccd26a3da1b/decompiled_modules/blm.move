module 0x82584e182eedfd3ef7f17f7102e89f9b1fa88c79a888debfc0a77ccd26a3da1b::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLM>(arg0, 9, b"BLM", b"Bloom", b"New year blooming of Sui.  Celebrate with us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9d751105c911bda263b7dd19e101a431blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

