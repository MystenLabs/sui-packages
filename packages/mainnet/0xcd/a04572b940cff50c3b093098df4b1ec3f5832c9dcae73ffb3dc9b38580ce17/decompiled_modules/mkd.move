module 0xcda04572b940cff50c3b093098df4b1ec3f5832c9dcae73ffb3dc9b38580ce17::mkd {
    struct MKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKD>(arg0, 9, b"MKD", b"Alexander", b"Alexander the Great, created one of the largest empires of the ancient world in little over a decade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6bb2d7d-a1b0-43a7-8804-59e554d78447.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

