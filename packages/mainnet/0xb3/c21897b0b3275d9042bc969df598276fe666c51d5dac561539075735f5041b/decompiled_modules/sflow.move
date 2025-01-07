module 0xb3c21897b0b3275d9042bc969df598276fe666c51d5dac561539075735f5041b::sflow {
    struct SFLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOW>(arg0, 9, b"SFLOW", b"Flower Spring", b"Spring Flower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4a178ee1d33deb14de428235a6c478d2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFLOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

