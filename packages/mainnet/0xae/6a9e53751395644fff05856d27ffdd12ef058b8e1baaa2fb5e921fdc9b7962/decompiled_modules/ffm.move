module 0xae6a9e53751395644fff05856d27ffdd12ef058b8e1baaa2fb5e921fdc9b7962::ffm {
    struct FFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFM>(arg0, 9, b"FFM", b"feminine", b"boldly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66708805-9880-443b-8dba-700dd7dcd3d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFM>>(v1);
    }

    // decompiled from Move bytecode v6
}

