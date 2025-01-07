module 0x10d771de106c5ec62b04141a877d3d2a3aaa40bf8a81de20263645ce0290abfe::dum {
    struct DUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUM>(arg0, 9, b"DUM", b"Dummy", b"Dummy panda not a real panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94600205-3a36-4034-82f9-0f88dee1b30d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

